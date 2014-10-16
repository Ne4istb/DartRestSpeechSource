import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart';
import 'package:shelf_route/shelf_route.dart';

void main() {

  var helloRouter = router()
    ..get('/hello/{name}', (request) => new Response.ok("Hello, ${getPathParameter(request, 'name')}!"));

  io.serve(helloRouter.handler, 'localhost', 8080);
}
