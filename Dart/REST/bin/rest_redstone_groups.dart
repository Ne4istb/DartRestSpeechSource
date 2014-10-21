import 'package:redstone/server.dart' as app;

@app.Group("/devfest/speeches")
class DevFestSpeechService {

  var speeches;

  DevFestSpeechService() {
    speeches = new SpeechRepository();
  }

  @app.Route("/find")
  findSpeech(@app.QueryParam("stream") String stream,
             @app.QueryParam("speaker") String name) {
    return speeches.find(stream, name);
  }

  @app.Route("/like/:id", methods: const [app.POST])
  likeSpeech(String id) {
    speeches.like(id);
  }
}

main() {
  app.start();
}

class SpeechRepository {
  find(stream, name) => "test";
  like(id) => print(id);
}
