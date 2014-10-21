import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart';
import 'package:shelf_route/shelf_route.dart';
import 'package:shelf_bind/shelf_bind.dart';
import 'package:shelf_exception_response/exception_response.dart';
import 'dart:convert' show JSON;
import 'dart:async';

import 'package:constrain/constrain.dart';
import 'package:matcher/matcher.dart';

var handlerAdapter = handlerAdapter(validateParameters: true);
var speechRouter = router(handlerAdapter: handlerAdapter)
  ..post('/devfest/speeches', _create);

var speeches = new SpeechRepository();

@ResponseHeaders.created(idField: #id)
Speech _create(@RequestBody() Speech speech) {
  speeches.add(speech);
  return speech;
}

var handler = const Pipeline()
.addMiddleware(exceptionResponse())
.addHandler(speechRouter.handler);

void main() {
  io.serve(handler, 'localhost', 8080);
}

class Speech {

  String _name;

  @NotNull()
  @Ensure(isNotEmpty)
  String get name => _name;

  @NotNull()
  set name(String value) => _name = value;

  @NotNull()
  @Ensure(descriptionIsAtLeast10Chars,
          description: 'min 10 characters')
  final String description;

  final String author;

  Speech.fromJson(Map json) :
    this._name = json['name'],
    this.description = json['description'],
    this.author = json['author_name'];

  Map toJson() =>
    { 'name': name,
      'description': description,
      'author_name': author };
}

Matcher descriptionIsAtLeast10Chars() =>
  hasLength(greaterThan(10));

class SpeechRepository {
  find(stream, name) => "test";

  like(id) => print(id);

  get(id) => id;

  update(id, data) => print("Update $id $data");

  add(data) => print("Add $data");

  delete(id) => print("Delete $id");
}