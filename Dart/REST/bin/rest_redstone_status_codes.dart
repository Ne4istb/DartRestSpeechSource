import 'package:redstone/server.dart' as app;
import 'package:shelf/shelf.dart' as shelf;
import 'dart:io' show HttpStatus;

@app.Group("/devfest/speeches")
class DevFestService extends BaseApiService {

  var speeches;

  DevFestService() {
    speeches = new SpeechRepository();
  }

  @app.Route("/:id")
  get(String id) {
    var speech = speeches.get(id);
    return new shelf.Response.ok(speech);
  }

  @app.Route("/", methods: const [app.POST])
  add(@app.Body(app.JSON) Map speech) {
    speeches.add(speech);
    return new shelf.Response(201);
  }
}

main() {
  app.start();
}


class BaseApiService {
  OK([Object data]) {
    return {
        "test": "test"
    };
  }

  NoContent() {
    print("No content");
  }
}

class SpeechRepository {
  find(stream, name) => "test";

  like(id) => print(id);

  get([id]) => id;

  update(id, data) => print("Update $id $data");

  add(data) => print("Add $data");

  delete(id) => print("Delete $id");
}
//
//@app.Group("/devfest/speeches")
//class DevFestService extends BaseApiService {
//
//  var speeches;
//
//  DevFestService() {
//    speeches = new SpeechRepository();
//  }
//
//  @app.Route("/:id")
//  get(String id) {
//    var speech = speeches.get(id);
//    return new shelf.Response.ok(speech);
//  }
//
//  @app.Route("/", methods: const [app.POST])
//  add(@app.Body(app.JSON) Map speech) {
//    speeches.add(speech);
//    return new shelf.Response(201);
//  }
//}