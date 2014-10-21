import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart';
import 'package:shelf_route/shelf_route.dart';
import 'package:shelf_bind/shelf_bind.dart';
import 'package:shelf_exception_response/exception_response.dart';
import 'dart:convert' show JSON;
import 'dart:async';

var speeches = new SpeechRepository();

@ResponseHeaders()
Speech _getSpeech(String id) {
  var speech = speeches.get(id);
  if (speech == null) throw new NotFoundException();
  return speech;
}

var speechRouter = router(handlerAdapter: handlerAdapter())
  ..get('/devfest/speeches/{id}', _getSpeech, middleware: speechExceptionHandler());

var handler = const Pipeline().addMiddleware(notFound()).addHandler(speechRouter.handler);

Middleware notFound() {
  return (Handler handler) {
    return (Request request) {
      return new Future.sync(() => handler(request))
      .then((response) => response)
      .catchError((_) => new Response.found("/error/not_found.html"), test: (e) => e is NotFoundException);
    };
  };
}

Middleware speechExceptionHandler() {
  return (Handler handler) {
    return (Request request) {
      return new Future.sync(() => handler(request)).then((response) => response)
      .catchError((error, stackTrace) {
        //process
        return new Response.internalServerError(body: error.toString());
      }, test: (e) => e is SpeechException);
    };
  };
}

void main() {
  io.serve(handler, 'localhost', 8080);
}




class SpeechException extends Error {

  SpeechException() : super();
}

class Speech {
  String id;

  Speech.fromJson(Map json) :this.id = json['test'];

  Map toJson() => {
      'test': id
  };
}

class SpeechRepository {
  find(stream, name) => "test";

  like(id) => print(id);

  get(id) => throw new SpeechException();

  update(id, data) => print("Update $id $data");

  add(data) => print("Add $data");

  delete(id) => print("Delete $id");
}