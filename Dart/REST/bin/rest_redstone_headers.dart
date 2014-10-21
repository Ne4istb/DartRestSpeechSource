import 'package:redstone/server.dart' as app;
import 'package:shelf/shelf.dart' as shelf;
import 'dart:convert' show UTF8, JSON;

@app.Group("/devfest/speeches")
class DevFestService extends BaseApiService {
  var speeches;

  DevFestService() {
    speeches = new SpeechRepository();
  }

  @app.Route("/:id")
  get(String id) {

    var speech = speeches.get(id);
    var version = speech["version"];

    var response = new shelf.Response
      .ok(JSON.encode(speech))

      .change(headers: {
        "ETag": "\"$version\"",
        "Access-Control-Allow-Origin": "*"
      });

    return response;
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

  get(id) => {
      "id": id, "version": 5
  };

  update(id, data) => print("Update $id $data");

  add(data) => print("Add $data");

  delete(id) => print("Delete $id");
}
