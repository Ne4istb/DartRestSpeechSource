import 'package:redstone/server.dart' as app;

@app.Route("/hello/:name")
hello(String name) => "Hello $name!";

main() {
  app.start();
}


