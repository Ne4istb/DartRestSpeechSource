import 'package:start/start.dart';

void main() {
  start(port: 8080).then((Server app) {

    var speeches = new SpeechRepository();

    app.get('/devfest/speeches/:id').listen((request) {

      var id = request.param('id');
      var speech = speeches.get(id);
      var version = speech["version"];

      request.response

        ..header('Content-Type', 'application/json')
        ..header("ETag", "\"$version\"")
        ..header("Access-Control-Allow-Origin", "*")

        ..json(speech);
    });
  });
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