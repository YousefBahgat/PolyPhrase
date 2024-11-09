import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutputlanguageNotifier extends StateNotifier<String> {
  OutputlanguageNotifier() : super('ar');

  void changeTheoutputLanguageStatus(String lang) {
    state = lang;
  }
}

final outputLanguageProvider =
    StateNotifierProvider<OutputlanguageNotifier, String>((ref) {
  return OutputlanguageNotifier();
});
