import 'dart:io';

final HOST = "127.0.0.1";
final PORT = 8080;

void main() {

  HttpServer.bind("127.0.0.1", 8080).then((server) {
    server.listen((HttpRequest request) {

      switch (request.method) {
        case "GET":
          handleGet(request);
          break;
        case "POST":
          handlePost(request);
          break;
        case "OPTIONS":
          handleOptions(request);
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

handleGet(HttpRequest httpRequest) {

}

handlePost(HttpRequest httpRequest) {

}

handleOptions(HttpRequest httpRequest) {

}

defaultHandler(HttpRequest httpRequest) {

}