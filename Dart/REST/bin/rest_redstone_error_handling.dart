import 'package:redstone/server.dart' as app;
import 'package:shelf/shelf.dart' as shelf;
import 'dart:convert' show JSON;
import 'dart:io';

@app.Group("/devfest/speech")
class DevFestService extends BaseApiService {

  var speeches;

  DevFestService() {
    speeches = new SpeechRepository();
  }

  @app.ErrorHandler(HttpStatus.INTERNAL_SERVER_ERROR)
  handleInternalServerError() {
    if (app.chain.error is SpeechException) {
      //process error
    }
  }

  @app.Route("/:id")
  get(String id) {

    Object speech;
    try {
      speech = speeches.get(id);
    }
    on SpeechException catch(exception) {
      return new app.ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, exception);
    }

    if (!speech)return new app.ErrorResponse(HttpStatus.NOT_FOUND, "Speech is not found");

    return new shelf.Response.ok(JSON.encode(speech));
  }
}

@app.ErrorHandler(HttpStatus.NOT_FOUND, urlPattern: r'/devfest/.+')
handleNotFoundError() => app.redirect("/error/not_found.html");

main() {
  app.start();
}

class SpeechException extends Error {

  SpeechException() : super();
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
