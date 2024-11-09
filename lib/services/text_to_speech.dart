import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  FlutterTts tts = FlutterTts();
  final List<String> _languagesList = [
    'ar-EG',
    'en-US',
    'es-ES',
    'fr-FR',
    'ja-JP'
  ];

  setLangauge(String language) {
    for (var lang in _languagesList) {
      if (language == lang.substring(0, 2)) {
        tts.setLanguage(lang);
      }
    }
  }

  start(String text) async {
    await tts.setVolume(1.0);
    await tts.speak(text);
  }
}
