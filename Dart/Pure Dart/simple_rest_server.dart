import 'dart:io';

void main() {

  HttpServer.bind("127.0.0.1", 8080).then((server) {
    server.listen((HttpRequest request) {

      request.response
        ..write("Hello from Dart!")
        ..close();

    });
  });
}
