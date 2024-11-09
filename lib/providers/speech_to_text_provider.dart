import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:polyphrase/providers/input_text_provider.dart';
import 'package:polyphrase/services/speech_to_text.dart';

final speechToTextProvider =
    StateNotifierProvider<SpeechService, SpeechState>((ref) {
  final changeInputText =
      ref.read(inputTextProvider.notifier).changeTheInputText;
  return SpeechService(changeInputText);
});
