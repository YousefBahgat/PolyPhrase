// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polyphrase/providers/input_text_provider.dart';

import 'package:polyphrase/providers/inputlanguage_provider.dart';
import 'package:polyphrase/providers/output_text_provider.dart';
import 'package:polyphrase/providers/outputlanguage_provider.dart';

import '../providers/speech_to_text_provider.dart';

// ignore: must_be_immutable
class CustomDropdown extends ConsumerWidget {
  String label;

  String? inputLanguage;
  String? outputLanguage;

  var speechToTextService;
  CustomDropdown({
    super.key,
    required this.label,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    speechToTextService = ref.read(speechToTextProvider.notifier);
    if (label == 'Translate from') {
      inputLanguage = ref.watch(inputLanguageProvider);
    } else {
      outputLanguage = ref.watch(outputLanguageProvider);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.ubuntuCondensed(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: dropDownButtonDecoration(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
              value: label == 'Translate from' ? inputLanguage : outputLanguage,
              isExpanded: true,
              underline: const SizedBox(),
              /* hint: Text(
                "Select Language",
                style: GoogleFonts.ubuntuCondensed(color: Colors.black54),
              ), */
              items: languageList(),
              onChanged: (value) {
                changeLanguage(ref, value);
              },
            ),
          ),
        ),
      ],
    );
  }

  void changeLanguage(WidgetRef ref, String? value) {
    if (label == 'Translate from') {
      //stop recording if the mic is open
      speechToTextService.stopListening();
      //change the input language state
      ref
          .read(inputLanguageProvider.notifier)
          .changeTheInputLanguageStatus(value!);
      // if the input language changed then empty the input field text
      ref.read(inputTextProvider.notifier).changeTheInputText('');
    } else {
      // change the output language state
      ref
          .read(outputLanguageProvider.notifier)
          .changeTheoutputLanguageStatus(value!);
      // if the output language changed then empty the output field text
      ref.read(outputTextProvider.notifier).changeTheOutputText('');
    }
  }

  BoxDecoration dropDownButtonDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blueAccent, width: 2),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 6,
          offset: Offset(2, 2),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> languageList() {
    return ['en', 'fr', 'ar', 'es', 'ja']
        .map((String value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: GoogleFonts.ubuntuCondensed(color: Colors.black),
              ),
            ))
        .toList();
  }
}
