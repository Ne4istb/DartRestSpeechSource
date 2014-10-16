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
  Object speech;
  try {
    speech = speeches.get(id);
  }
  on SpeechException catch(exception) {
    throw new SpeechHttpException(exception);
  }

  if (speech == null)
    throw new NotFoundException();

  return speech;
}

//@ResponseHeaders.created(idField: #id)
//Speech _create(@RequestBody() Speech speech) {
//  speeches.add(speech);
//  return speech;
//}
//
var speechRouter = router(handlerAdapter: handlerAdapter())
  ..get('/ohnoes', () => throw new SpeechHttpException())
  ..get('/devfest/speeches/{id}', _getSpeech, middleware: exceptionResponse());
//  ..post('/devfest/speeches', _create);

var handler = const Pipeline()
// add exception response middleware to the pipeline
.addMiddleware(exceptionResponse()).addHandler(speechRouter.handler);

void main() {
  io.serve(handler, 'localhost', 8080);
}

//
//@app.Route("/:id")
//get(String id) {
//
//  Object speech;
//  try {
//    speech = speeches.get(id);
//  }
//  on SpeechException catch(exception) {
//    return new SpeechHttpException();
//  }
//
//  if (!speech)return new app.ErrorResponse(HttpStatus.NOT_FOUND, "Speech is not found");
//
//  return new shelf.Response.ok(JSON.encode(speech));
//}

class SpeechException extends Error {

  SpeechException() : super();
}

class SpeechHttpException extends HttpException {

  final int status = 500;
  final Map<String, dynamic> data;

  String message;

  SpeechHttpException([Error exception, this.data]) {
    message = exception.toString();
    print("test");
  }

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

  get(id) => id;

  update(id, data) => print("Update $id $data");

  add(data) => print("Add $data");

  delete(id) => print("Delete $id");
}