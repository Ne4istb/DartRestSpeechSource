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
  @NotEmpty()
  String get name => _name;

  @Field()
  set name(String value) => _name = value;

  @Field()
  @Range(min: 10, required: true)
  String description;

  @Field()
  @Range(min: 20, required: true)
  int length;

  @Field(view: "author_name")
  String author;

  @Field()
  @OnlyNumbers()
  @Matches(r"(\d{10})")
  String phoneNumber;
}

var speechValidator = new Validator(Speech, true);

@app.Route('/devfest/speeches', methods: const[app.POST])
addSpeech(@Decode() Speech speech) {

  ValidationError err = speechValidator.execute(speech);
  if (err != null) {
    print(err);
  }
}

@app.Route('/devfest/speeches')
@Encode()
Speech get() {

}
