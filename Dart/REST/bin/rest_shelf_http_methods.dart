import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart';
import 'package:shelf_route/shelf_route.dart';
import 'dart:convert' show JSON;

void main() {

  var speeches = new SpeechRepository();

  var speechRouter = router()

    ..add('/devfest/speeches/{id}', ['GET', 'DELETE'], (request) {
      var id = getPathParameter(request, 'id');
      switch (request.method) {
        case "GET":
          return new Response.ok(speeches.get(id));
        case "DELETE":
          speeches.delete(id);
          return new Response(204);
      }
    })

    ..post('/devfest/speeches', (request) {
      return request.readAsString().then((String content) {
        var speech = JSON.decode(content);
        speeches.add(speech);
        return new Response(201);
      });
    })

    ..put('/devfest/speeches/{id}', (request) {
      return request.readAsString().then((String content) {

        var id = getPathParameter(request, 'id');
        var speech = JSON.decode(content);

        speeches.update(id, speech);

        return new Response(204);
      });
  });

  io.serve(speechRouter.handler, 'localhost', 8080);
}

class SpeechRepository {
  find(stream, name) => "test";

  like(id) => print(id);

  get(id) => id;

  update(id, data) => print("Update $id $data");

  add(data) => print("Add $data");

  delete(id) => print("Delete $id");
}

