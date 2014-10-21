import 'package:redstone/server.dart' as app;

@app.Group("/devfest/speeches")
class DevFestService extends BaseApiService {

  var speeches;

  DevFestService() {
    speeches = new SpeechRepository();
  }

  @app.Route("/:id", methods: const [app.GET, app.DELETE])
  get(String id) {
    switch (app.request.method) {
      case "GET":
        return speeches.get(id);
      case "DELETE":
        speeches.delete(id);
    }
  }

  @app.Route("", methods: const [app.POST])
  add(@app.Body(app.JSON) Map speech) {
    speeches.add(speech);
  }

  @app.Route("/:id", methods: const [app.PUT])
  update(String id, @app.Body(app.JSON) Map speech) {
    speeches.update(id, speech);
  }
}

main() {
  app.start();
}


class BaseApiService {
  OK([Object data]) {
    return {"test": "test"};
  }

  NoContent() {
    print("No content");
  }
}


class SpeechRepository {
  find(stream, name) => "test";

  like(id) => print(id);
}
