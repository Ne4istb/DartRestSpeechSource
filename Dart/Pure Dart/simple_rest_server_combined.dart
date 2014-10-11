import 'dart:io';

final HOST = "127.0.0.1";
final PORT = 8080;

void main() {

  HttpServer.bind("127.0.0.1", 8080).then((server) {
    server.listen((HttpRequest request) {

      switch (request.uri.toString()){
        case "/user":
          handleUserRequest(request);
          break;
        case "/example":
          handleExample(request);
          break;
        default:
          defaultHandler(request);
      }
    },
    onError: printError);
  });
}

handleUserRequest(HttpRequest request) {
  switch (request.method) {
    case "GET":
      handleUserGet(request);
      break;
    case "POST":
      handleUserPost(request);
      break;
  }
}

handleUserGet(HttpRequest httpRequest) {
  HttpResponse response = request.response;

  //handle request

  addCorrespondingHeaders(response);
}


handleUserPost(HttpRequest httpRequest) {

}

handleExample(HttpRequest httpRequest) {

}

defaultHandler(HttpRequest httpRequest) {

}
void printError(error) => print(error);