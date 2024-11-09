import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputlanguageNotifier extends StateNotifier<String> {
  InputlanguageNotifier() : super('en');

  void changeTheInputLanguageStatus(String lang) {
    state = lang;
  }
}

final inputLanguageProvider =
    StateNotifierProvider<InputlanguageNotifier, String>((ref) {
  return InputlanguageNotifier();
});
