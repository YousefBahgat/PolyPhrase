import 'package:flutter/material.dart';

import '../widgets/language_selectors.dart';
import '../widgets/text_inputbox.dart';
import '../widgets/translaton_button.dart';

class TranslationScreen extends StatelessWidget {
  const TranslationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: pageDecoration(),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const LanguageSelectors(),
                const SizedBox(height: 20),
                TextInputBox(
                  hint: "Enter text to translate...",
                  hasSpeechToText: true,
                  hasTextToSpeech: true,
                ),
                const SizedBox(height: 20),
                TranslateButton(),
                const SizedBox(height: 20),
                TextInputBox(
                  hint: "Translation result...",
                  hasSpeechToText: false,
                  hasTextToSpeech: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration pageDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF7F7FD5), Color(0xFF86A8E7), Color(0xFF91EAE4)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }
}
