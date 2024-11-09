import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'translation_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF7AD7F0), // Light Blue
                Color(0xFF00FFFF), // Aqua
                Color(0xFFDDA0DD), // Light Purple
                Color(0xFFFF69B4), // Pink
                Color(0xFF40E0D0), // Turquoise
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: EasySplashScreen(
            logo: Image.asset('assets/polyphrase.png'),
            title: Text(
              'PolyPhrase',
              style: GoogleFonts.ubuntuCondensed(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            showLoader: true,
            loadingText: Text('Loading...',
                style: GoogleFonts.ubuntuCondensed(fontSize: 24)),
            navigator: const TranslationScreen(),
            durationInSeconds: 3,
          ),
        ),
      ),
    );
  }
}
