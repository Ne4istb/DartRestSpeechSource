import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart';
import 'package:shelf_route/shelf_route.dart';
import 'package:shelf_bind/shelf_bind.dart';
import 'dart:convert' show JSON;
import 'dart:async';

var speeches = new SpeechRepository();

var speechRouter = router(handlerAdapter: handlerAdapter())
  ..get('{id}', _getSpeech)
  ..post('/devfest/speeches', _create);

@ResponseHeaders(successStatus: 200)
Speech _getSpeech(String id) => speeches.get(id);

@ResponseHeaders.created(idField: #id)
Speech _create(@RequestBody() Speech speech) {
  speeches.add(speech);
  return speech;
}

void main() {
  io.serve(speechRouter.handler, 'localhost', 8080);
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