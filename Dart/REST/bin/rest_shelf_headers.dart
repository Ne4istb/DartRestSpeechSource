import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart';
import 'package:shelf_route/shelf_route.dart';
import 'package:shelf_bind/shelf_bind.dart';
import 'dart:convert' show JSON;

void main() {

  var speeches = new SpeechRepository();

  var speechRouter = router(handlerAdapter: handlerAdapter())
    ..get('/devfest/speeches/{id}', (String id) {

    var speech = speeches.get(id);
    var version = speech["version"];

    var response = new Response
      .ok(JSON.encode(speech))
      .change(headers: {
        "Content-Type": "application/json",
        "ETag": "\"$version\"", "Access-Control-Allow-Origin": "*"
      });

    return response;
  });

  io.serve(speechRouter.handler, 'localhost', 8080);
}

class SpeechRepository {
  find(stream, name) => "test";

  like(id) => print(id);

  get(id) => {
      "id": id, "version": 5
  };

  update(id, data) => print("Update $id $data");

  add(data) => print("Add $data");

  delete(id) => print("Delete $id");
}