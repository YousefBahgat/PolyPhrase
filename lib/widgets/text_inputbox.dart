// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polyphrase/providers/input_text_provider.dart';
import 'package:polyphrase/providers/inputlanguage_provider.dart';
import 'package:polyphrase/providers/output_text_provider.dart';
import 'package:polyphrase/providers/outputlanguage_provider.dart';
import 'package:polyphrase/services/text_to_speech.dart';

import '../providers/speech_to_text_provider.dart';

// ignore: must_be_immutable
class TextInputBox extends ConsumerWidget {
  final String hint;
  final bool hasSpeechToText;
  final bool hasTextToSpeech;
  final TextToSpeech textToSpeech = TextToSpeech();

  TextInputBox({
    required this.hint,
    required this.hasSpeechToText,
    required this.hasTextToSpeech,
    super.key,
  });

  //speech to text
  var speechToTextState;
  var speechToTextService;
  //Input-text
  var inputTextNotifier;
  final inputController = TextEditingController();
  //output-text
  final outputController = TextEditingController();
  var outputTextNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    outputController.text = ref.watch(outputTextProvider);
    inputController.text = ref.watch(inputTextProvider);
    speechToTextState = ref.watch(speechToTextProvider);
    speechToTextService = ref.read(speechToTextProvider.notifier);
    inputTextNotifier = ref.read(inputTextProvider.notifier);
    outputTextNotifier = ref.read(outputTextProvider.notifier);
    return Container(
      padding: const EdgeInsets.all(16),
      height: 180,
      decoration: _containerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              controller: hasSpeechToText ? inputController : outputController,
              readOnly: hasSpeechToText ? false : true,
              maxLines: null,
              //maxLength: 5000,
              decoration: InputDecoration.collapsed(
                hintText: hint,
                hintStyle: GoogleFonts.ubuntuCondensed(color: Colors.black54),
              ),
              onChanged: (value) {
                if (hasSpeechToText) {
                  //onchange of the input update the state
                  inputTextNotifier.changeTheInputText(value);
                  //if the input text is empty ..make the output  translated text empty too
                  if (value == '') {
                    outputTextNotifier.changeTheOutputText('');
                  }
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (hasSpeechToText) ...[
                _buildSpeechTotextButton(ref),
                const SizedBox(width: 10),
              ],
              if (hasTextToSpeech) _buildTextToSpeechButton(ref),
            ],
          ),
        ],
      ),
    );
  }

  IconButton _buildTextToSpeechButton(WidgetRef ref) {
    return IconButton(
      icon: Icon(
        Icons.volume_up,
        // if the icon is disabled then change the color
        color: (inputController.text == '' && hasSpeechToText) ||
                (outputController.text == '' && !hasSpeechToText)
            ? const Color(0xFFB0BEC5)
            : Colors.blueAccent,
      ),
      onPressed: inputController.text == '' && hasSpeechToText
          ? null
          : outputController.text == '' && !hasSpeechToText
              ? null
              : () {
                  // if the icon is text To speech then apply the following:

                  if (hasSpeechToText) {
                    textToSpeech.setLangauge(ref.read(inputLanguageProvider));
                    textToSpeech.start(ref.read(inputTextProvider));
                  } else {
                    textToSpeech.setLangauge(ref.read(outputLanguageProvider));
                    textToSpeech.start(ref.read(outputTextProvider));
                  }
                },
      iconSize: 28,
    );
  }

  IconButton _buildSpeechTotextButton(WidgetRef ref) {
    return IconButton(
      icon: Icon(
        speechToTextState.isListening ? Icons.stop : Icons.mic,
        // if the icon is disabled then change the color
        color: speechToTextState.isListening ? Colors.red : Colors.blue,
      ),
      onPressed: () {
        if (!speechToTextState.isListening) {
          inputTextNotifier.changeTheInputText('');
        }
        // Toggle listening with desired locale
        speechToTextService.toggleListening(
            localeId: ref.read(inputLanguageProvider));
      },
      iconSize: 28,
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(2, 2),
        ),
      ],
    );
  }
}
