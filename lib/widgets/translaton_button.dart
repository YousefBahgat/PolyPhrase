import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polyphrase/providers/output_text_provider.dart';
import '../providers/input_text_provider.dart';
import '../providers/inputlanguage_provider.dart';
import '../providers/outputlanguage_provider.dart';

import '../services/tranlsation.dart';

// ignore: must_be_immutable
class TranslateButton extends ConsumerWidget {
  TranslateButton({super.key});
  var translator = Tranlsation();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => translate(ref),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8,
        ),
        child: Text(
          "Translate",
          style: GoogleFonts.ubuntuCondensed(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  translate(WidgetRef ref) async {
    var inputText = ref.read(inputTextProvider);
    var inputLanguage = ref.read(inputLanguageProvider);
    var outputLanguage = ref.read(outputLanguageProvider);
    if (inputText == '') {
      ref.read(outputTextProvider.notifier).changeTheOutputText('');
    } else {
      String translatedText = await translator.translate(
        inputLanguage,
        outputLanguage,
        inputText,
      );
      ref.read(outputTextProvider.notifier).changeTheOutputText(translatedText);
    }
  }
}
