import 'package:translator/translator.dart';

class Tranlsation {
  final translator = GoogleTranslator();

  Future<String> translate(
      String inputLang, String outputLang, String text) async {
    final translated =
        await translator.translate(text, from: inputLang, to: outputLang);
    return translated.text;
  }
}
