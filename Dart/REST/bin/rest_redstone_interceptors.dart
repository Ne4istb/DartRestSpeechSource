import 'package:redstone/server.dart' as app;
import 'package:shelf/shelf.dart' as shelf;
import 'dart:convert' show JSON;
import 'dart:io';

@app.Group("/devfest/speeches")
class DevFestService extends BaseApiService {

  var speeches;

  DevFestService() {
    speeches = new SpeechRepository();
  }

  @app.Route("/:id")
  get(String id) {
    var speech = speeches.get(id);
    return new shelf.Response.ok(JSON.encode(speech));
  }
}

@app.Interceptor(r'/devfest/.*', chainIdx: 0)
loginFilter() {
  if (app.request.session["username"] != null)
    app.chain.next();
  else
    app.chain.interrupt(statusCode: HttpStatus.UNAUTHORIZED);
    //or app.redirect("/login.html");
}

@app.Interceptor(r'/devfest/.*', chainIdx: 1)
dbConnInterceptor() {
  var connection = new DbConn();
  app.request.attributes["dbConn"] = connection;
  app.chain.next(() => connection.close());
}


main() {
  app.start();
}

class SpeechException extends Error {

  SpeechException() : super();
}

class DbConn {
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
