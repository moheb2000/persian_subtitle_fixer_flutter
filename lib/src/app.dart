import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_fonts/persian_fonts.dart';
import './screens/intro_screen.dart';
import './screens/main_screen.dart';
import './resources/db.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'اصلاح زیرنویس پارسی',

      // Theme config
      theme: ThemeData(
        fontFamily: PersianFonts.Vazir.fontFamily,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: PersianFonts.Vazir.fontFamily,
      ),

      themeMode: ThemeMode.system,

      // Localization config
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"),
      ],
      locale: Locale("fa", "IR"),

      // Home
      home: FutureBuilder(
        future: db.syncDb(),
        builder: (context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data == null ? IntroScreen() : MainScreen();
          } else {
            return IntroScreen();
          }
        },
      ),
    );
  }
}
