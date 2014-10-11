import 'dart:io';

/* A simple web server that responds to **ALL** GET requests by returning
 * the contents of data.json file, and responds to ALL **POST** requests
 * by overwriting the contents of the data.json file
 * 
 * Browse to it using http://localhost:8080  
 * 
 * Provides CORS headers, so can be accessed from any other page
 */

final HOST = "127.0.0.1";
final PORT = 8080;
final DATA_FILE = "data.json";

void main() {

  HttpServer.bind(HOST, PORT).then((server) {
    server.listen((HttpRequest request) {
      print(request.uri);
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
        default: defaultHandler(request);
      }
    },
    onError: printError);

    print("Listening for GET and POST on http://$HOST:$PORT");
  },

  onError: printError);
}

void handleGet(HttpRequest request) {

  HttpResponse response = request.response;

  print("${request.method}: ${request.uri.path}");

  addCorrespondingHeaders(response);

  var file = new File(DATA_FILE);
  if (file.existsSync()) {
    response.headers.add(HttpHeaders.CONTENT_TYPE, "application/json");
    file.readAsBytes().asStream().pipe(response); // automatically close output stream
  }
  else {
    var err = "Could not find file: $DATA_FILE";
    response.addString(err);
    response.close();
  }

}

void handlePost(HttpRequest req) {
  HttpResponse res = req.response;
  print("${req.method}: ${req.uri.path}");

  addCorrespondingHeaders(res);

  req.listen((List<int> buffer) {
    var file = new File(DATA_FILE);
    var ioSink = file.openWrite(); // save the data to the file
    ioSink.add(buffer);
    ioSink.close();

    // return the same results back to the client
    res.add(buffer);
    res.close();
  },
  onError: printError);
}

void addCorrespondingHeaders(HttpResponse response) {
  response.headers.add("Access-Control-Allow-Origin", "*, ");
  response.headers.add("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
  response.headers.add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
}

void handleOptions(HttpRequest req) {
  HttpResponse res = req.response;
  addCorrespondingHeaders(res);
  print("${req.method}: ${req.uri.path}");
  res.statusCode = HttpStatus.NO_CONTENT;
  res.close();
}

void defaultHandler(HttpRequest req) {
  HttpResponse res = req.response;
  addCorrespondingHeaders(res);
  res.statusCode = HttpStatus.NOT_FOUND;
  res.addString("Not found: ${req.method}, ${req.uri.path}");
  res.close();
}

void printError(error) => print(error);