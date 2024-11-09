import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polyphrase/screens/splash_screen.dart';

void main() => runApp(const ProviderScope(child: PolyPhraseApp()));

class PolyPhraseApp extends StatelessWidget {
  const PolyPhraseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PolyPhrase',
      theme: appTheme(context),
      home: const SplashPage(),
    );
  }

  ThemeData appTheme(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: GoogleFonts.ubuntuCondensedTextTheme(
        Theme.of(context).textTheme,
      ).copyWith(
        bodyMedium: GoogleFonts.ubuntuCondensed(
          color: Colors.black87,
        ),
      ),
      disabledColor: Colors.grey,
    );
  }
}
