import 'package:flutter/material.dart';
import 'package:persian_fonts/persian_fonts.dart';
import 'package:get/get.dart';
import './screens/intro_screen.dart';
import './screens/main_screen.dart';
import './resources/db.dart';
import './logic/logic.dart';
import './languages/languages.dart';

class App extends StatelessWidget {
  final logic = Get.put(Logic());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'اصلاح زیرنویس پارسی',

      // Theme config
      theme: ThemeData(
        fontFamily: PersianFonts.Vazir.fontFamily,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: PersianFonts.Vazir.fontFamily,
      ),

      // Localization config
      translations: Languages(),
      locale: Locale('fa', 'IR'),
      fallbackLocale: Locale('fa', 'IR'),

      // Home
      home: db.defaultDirectoryPath == null ? IntroScreen() : MainScreen(),
    );
  }
}
