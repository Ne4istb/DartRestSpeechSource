import 'package:redstone/server.dart' as app;


main() {

  app.addShelfMiddleware(...);

  app.setShelfHandler(...);

  app.setupConsoleLog();
  app.start();

}

