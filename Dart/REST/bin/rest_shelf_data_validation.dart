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

var speechRouter = router(handlerAdapter: handlerAdapter(validateParameters: true))
  ..get('/devfest/speeches/{id}', _getSpeech)
  ..post('/devfest/speeches', _create);

var handler = const Pipeline()
.addMiddleware(exceptionResponse())
.addHandler(speechRouter.handler);

void main() {
  io.serve(handler, 'localhost', 8080);
}

//
//class Speech {
//  @NotNull()
//  String id;
//
//  Speech.fromJson(Map json) :
//  this.id = json['test'];
//
//  Map toJson() => { 'test': id };
//}

class Speech {
  @NotNull()
  @Ensure(nameIsAtLeast3Chars, description: 'name must be at least 3 characters')
  final String name;


  Speech.build({this.name});

  Speech.fromJson(Map json) :
  this.name = json['name'];

  Map toJson() => { 'name': name };

  String toString() => 'Speech[name: $name]';
}


class SpeechRepository {
  find(stream, name) => "test";

  like(id) => print(id);

  get(id) => id;

  update(id, data) => print("Update $id $data");

  add(data) => print("Add $data");

  delete(id) => print("Delete $id");
}