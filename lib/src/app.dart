import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/intro_screen.dart';
import './screens/main_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Theme config
      theme: ThemeData(
        fontFamily: PersianFonts.Vazir.fontFamily,
      ),

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
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data!.getString('subtitlePath'));
            return snapshot.data!.getString('subtitlePath') == null ? IntroScreen() : MainScreen();
          } else {
            return IntroScreen();
          }
        },
      ),
    );
  }
}
