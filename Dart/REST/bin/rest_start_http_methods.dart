import 'package:start/start.dart';

void main() {
  start(port: 8080).then((Server app) {

    var speeches = new SpeechRepository();

    app.get('/devfest/speeches/:id').listen((request) {

      var id = request.param('id');
      var speech = speeches.get(id);

      request.response.json(speech);
    });

    app.post('/devfest/speech').listen((request) {
      request.payload().then((speech){
        speeches.add(speech);
        request.response.close();
      });
    });

    app.put('/devfest/speeches/:id').listen((request) {

      var id = request.param('id');

      request.payload().then((speech){
        speeches.update(id, speech);
        request.response.close();
      });
    });

    app.delete('/devfest/speeches/:id').listen((request) {

      var id = request.param('id');
      var speech = speeches.delete(id);

      request.response.close();
    });
  });
}

class SpeechRepository {
  find(stream, name) => "test";
  like(id) => print(id);

  get(id) => id;
  update(id, data) => print("Update $id $data");
  add(data) => print("Add $data");
  delete(id) => print("Delete $id");
}


//
//app.get('/devfest/speeches/:id', function(request, response){
//
//  var id = request.params.id;
//  var speech = speeches.get(id);
//
//  response.end(speech);
//});
//
//app.delete('/devfest/speeches/:id', function(request, response){
//
//  var id = request.params.id;
//  speeches.remove(id);
//
//  response.end();
//});
//
//app.put('/devfest/speeches/:id', function(request, response){
//
//  var id = request.params.id;
//  var speech = request.body;
//  speeches.update(id, speech);
//
//  response.end();
//});
//
//app.post('/devfest/speech', function(request, response){
//
//  var speech = request.body;
//  speeches.add(speech);
//
//  response.end();
//});
//
//app.listen(8080);
