import 'dart:io';

final HOST = "127.0.0.1";
final PORT = 8080;

void main() {

  HttpServer.bind("127.0.0.1", 8080).then((server) {
    server.listen((HttpRequest request) {

      switch (request.uri.toString()){
        case "/example":
          handleExample(request);
          break;
        case "/user":
          handleUser(request);
          break;
        case "/test":
          handleTest(request);
          break;
        default:
          defaultHandler(request);
      }
    },
    onError: printError);
  },

  onError: printError);
}

void printError(error) => print(error);

handleExample(HttpRequest httpRequest) {

}

handleUser(HttpRequest httpRequest) {

}

handleTest(HttpRequest httpRequest) {

}

defaultHandler(HttpRequest httpRequest) {

}