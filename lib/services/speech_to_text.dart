// speech_service.dart
// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService extends StateNotifier<SpeechState> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final Function(String) changeInputText; // Reference to update input text

  SpeechService(this.changeInputText) : super(SpeechState.initial());

  // Optional: Add a timer to handle inactivity
  // Timer? _listenTimeout;

  // Holds the full transcript of recognized text
  String _fullTranscript = "";

  String targetedLanguage = '';
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
        targetedLanguage = lang;
      }
    }
  }

  Future<void> toggleListening({required String localeId}) async {
    setLangauge(localeId);
    if (state.isListening) {
      stopListening();
    } else {
      await initializeAndStartListening();
    }
  }

  Future<void> initializeAndStartListening() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        print("Status: $status");

        // Automatically restart listening if the recognizer stops due to silence
        if (status == "notListening" && state.isListening) {
          restartListening(targetedLanguage);
        }
      },
      onError: (error) => print("Error: $error"),
    );

    if (available) {
      state = state.copyWith(isListening: true);
      // Set a timeout for inactivity if needed (optional)
      // _listenTimeout?.cancel();
      // _listenTimeout = Timer(const Duration(seconds: 30), stopListening);

      _speech.listen(
        onResult: (result) {
          final recognizedText = result.recognizedWords;
          if (result.finalResult) {
            _fullTranscript += " $recognizedText";
          }
          // Update the provider with the accumulated transcript
          state = state.copyWith(recognizedText: _fullTranscript);
          changeInputText(_fullTranscript);

          /* if (result.finalResult && result.recognizedWords.isNotEmpty) {
            restartListening(localeId);
          } */
        },
        localeId: targetedLanguage,
        listenFor: const Duration(minutes: 2), // Allow longer listening time
        pauseFor: const Duration(seconds: 3), // Pause to process without ending
        partialResults: true, // Enable partial results
      );
    }
  }

  Future<void> restartListening(String localeId) async {
    _speech.stop(); // Stop current session
    await Future.delayed(
        const Duration(milliseconds: 200)); // Short delay to reset
    await initializeAndStartListening(); // Restart session
  }

  void stopListening() {
    _speech.stop();
    // _listenTimeout?.cancel();
    state = state.copyWith(isListening: false);
    _fullTranscript = ""; //  Clear transcript
  }
}

// Define the state for the SpeechService
class SpeechState {
  final bool isListening;
  final String recognizedText;

  SpeechState({required this.isListening, required this.recognizedText});

  factory SpeechState.initial() =>
      SpeechState(isListening: false, recognizedText: '');

  SpeechState copyWith({bool? isListening, String? recognizedText}) {
    return SpeechState(
      isListening: isListening ?? this.isListening,
      recognizedText: recognizedText ?? this.recognizedText,
    );
  }
}
