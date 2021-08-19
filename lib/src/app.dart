import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_fonts/persian_fonts.dart';
import './screens/intro_screen.dart';
import './screens/main_screen.dart';
import './resources/db.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db.syncDb(),
      builder: (context, _) {
        return ValueListenableBuilder(
          valueListenable: db.themeModeNotifier,
          builder: (_, ThemeMode themeMode, __) {
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

              themeMode: themeMode,

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
              home: db.defaultDirectoryPath == null ? IntroScreen() : MainScreen(),
            );
          },
        );
      },
    );
  }
}
