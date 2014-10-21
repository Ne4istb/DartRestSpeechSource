import 'package:start/start.dart';
import 'package:shelf/shelf.dart' as shelf;

void main() {
  start(port: 8080).then((Server app) {

    var speeches = new SpeechRepository();

    app.get('/devfest/speeches').listen((request) {
      var speech = speeches.get();
      return new shelf.Response.ok(speech);
    });

    app.post('/devfest/speeches').listen((request) {
      request.payload().then((speech){
        speeches.add(speech);
        return new shelf.Response(201);
      });
    });
  });
}

class SpeechRepository {
  find(stream, name) => "test";
  like(id) => print(id);

  get([id]) => id;
  update(id, data) => print("Update $id $data");
  add(data) => print("Add $data");
  delete(id) => print("Delete $id");
}
