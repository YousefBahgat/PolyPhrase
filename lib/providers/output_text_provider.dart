import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutputTextNotifier extends StateNotifier<String> {
  OutputTextNotifier() : super('');

  void changeTheOutputText(String text) {
    state = text;
  }
}

final outputTextProvider =
    StateNotifierProvider<OutputTextNotifier, String>((ref) {
  return OutputTextNotifier();
});
