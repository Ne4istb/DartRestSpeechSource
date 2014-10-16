import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart';
import 'package:shelf_route/shelf_route.dart';
import 'package:shelf_bind/shelf_bind.dart';
import 'package:shelf_exception_response/exception_response.dart';
import 'dart:convert' show JSON;
import 'dart:async';

var speeches = new SpeechRepository();

@ResponseHeaders(successStatus: 200)
Speech _getSpeech(String id) => speeches.get(id);

@ResponseHeaders.created(idField: #id)
Speech _create(@RequestBody() Speech speech) {
  speeches.add(speech);
  return speech;
}

var speechRouter = router(handlerAdapter: handlerAdapter())
  ..get('/devfest/speeches/{id}', _getSpeech)
  ..post('/devfest/speeches', _create);

var handler = const Pipeline()
  .addMiddleware(exceptionResponse())
  .addMiddleware(loginMiddleware())
  .addMiddleware(dbConnMiddleware())
  .addHandler(speechRouter.handler);

void main() {
  io.serve(handler, 'localhost', 8080);
}

Middleware loginMiddleware() {

  return (Handler handler) {
    return (Request request) {
      if (request.headers["cookie"] != null && request.headers["cookie"].contains("username"))
        return handler(request);
      else
        throw new UnauthorizedException();
    };
  };
}

Middleware dbConnMiddleware() {

  return (Handler handler) {
    return (Request request) {
      var connection = new DbConn();
      return new Future.sync(() => handler(request)).then((response) {
        connection.close();
        return response;
      });
    };
  };
}

class DbConn {
  void close(){
  }
}

class Speech {
  String id;

  Speech.fromJson(Map json) :
  this.id = json['test'];

  Map toJson() => { 'test': id };
}

class SpeechRepository {
  find(stream, name) => "test";

  like(id) => print(id);

  get(id) => id;

  update(id, data) => print("Update $id $data");

  add(data) => print("Add $data");

  delete(id) => print("Delete $id");
}