import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:look_lock_app/views/splash_screen.dart';

import 'utils/theme_helper.dart';

void main() {
  runApp(const LookLockApp());
}

class LookLockApp extends StatelessWidget {
  const LookLockApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          background: ThemeHelper.background,
          primary: ThemeHelper.primary,
          secondary: ThemeHelper.secondary,
        ),
        brightness: Brightness.light,
        primaryColor: ThemeHelper.primary,
        fontFamily: GoogleFonts.firaSans().fontFamily,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.firaSans(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: ThemeHelper.primary,
          ),
          displayMedium: GoogleFonts.firaSans(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: ThemeHelper.primary,
          ),
          displaySmall: GoogleFonts.firaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ThemeHelper.primary,
          ),
        ),
      ),
      title: 'LookLock',
      home: const SplashScreen(),
    );
  }
}
