import 'package:start/start.dart';

void main() {
  start(port: 8080).then((Server app) {

    app.get('/hello/:name').listen((request) {
      request.response
        .header('Content-Type', 'text/html; charset=UTF-8')
        .send('Hello, ${request.param('name')}!');
    });

  });
}
