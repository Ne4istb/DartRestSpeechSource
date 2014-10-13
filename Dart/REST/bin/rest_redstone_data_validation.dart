import 'package:redstone/server.dart' as app;
import 'package:shelf/shelf.dart' as shelf;
import 'package:redstone_mapper/mapper.dart';
import 'package:redstone_mapper/plugin.dart';


main() {
  app.addPlugin(getMapperPlugin());
  app.start();
}

class Speech{

  String _name;

  @Field()
  String get name => _name;

  @Field()
  set name(String value) => _name = value;

  @Field(view: "author_name")
  String author;
}

@app.Route('/devfest/speech/add', methods: const[app.POST])
addSpeech(@Decode() Speech speech) {

}

@app.Route('/devfest/speech/list')
@Encode()
List<Speech> listSpeeches() {

}
