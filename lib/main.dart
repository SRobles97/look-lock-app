import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:look_lock_app/views/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'utils/theme_helper.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const LookLockApp());
}

class LookLockApp extends StatelessWidget {
  const LookLockApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!
              .unfocus(disposition: UnfocusDisposition.previouslyFocusedChild);
        }
      },
      child: MaterialApp(
        theme: ThemeData(
          iconTheme: const IconThemeData(
            color: ThemeHelper.background,
          ),
          colorScheme: const ColorScheme.light(
            background: ThemeHelper.background,
            primary: ThemeHelper.primary,
            secondary: ThemeHelper.secondary,
            tertiary: ThemeHelper.tertiary,
          ),
          brightness: Brightness.light,
          primaryColor: ThemeHelper.primary,
          fontFamily: GoogleFonts.firaSans().fontFamily,
          textTheme: TextTheme(
            displayLarge: GoogleFonts.firaSansCondensed(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: ThemeHelper.black,
            ),
            displayMedium: GoogleFonts.firaSans(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: ThemeHelper.black,
            ),
            displaySmall: GoogleFonts.firaSans(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: ThemeHelper.black,
            ),
            titleLarge: GoogleFonts.firaSans(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: ThemeHelper.black,
            ),
            titleMedium: GoogleFonts.firaSans(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: ThemeHelper.black,
            ),
            titleSmall: GoogleFonts.firaSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: ThemeHelper.black,
            ),
            bodyLarge: GoogleFonts.firaSans(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: ThemeHelper.black,
            ),
            bodyMedium: GoogleFonts.firaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ThemeHelper.black,
            ),
            bodySmall: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ThemeHelper.black,
            ),
          ),
        ),
        title: 'LookLock',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const SplashScreen(),
        supportedLocales: const [
          Locale('es', 'CL'),
        ],
      ),
    );
  }
}
