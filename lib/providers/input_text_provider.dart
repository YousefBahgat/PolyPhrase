import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputTextNotifier extends StateNotifier<String> {
  InputTextNotifier() : super('');

  void changeTheInputText(String text) {
    state = text;
  }
}

final inputTextProvider =
    StateNotifierProvider<InputTextNotifier, String>((ref) {
  return InputTextNotifier();
});
