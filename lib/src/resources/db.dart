import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Db {
  String? defaultDirectoryPath;
  late SharedPreferences prefs;
  final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.system);
  Future<void> syncDb() async {
    prefs = await SharedPreferences.getInstance();
    defaultDirectoryPath = prefs.getString('subtitlePath');
    final int? themeModeInt = prefs.getInt('themeModeInt');
    if (themeModeInt == 1) {
      themeModeNotifier.value = ThemeMode.light;
    } else {
      themeModeNotifier.value = ThemeMode.dark;
    }
  }
}

Db db = new Db();