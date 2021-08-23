import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class Db extends GetxController {
  String? defaultDirectoryPath;
  late SharedPreferences prefs;
  late int? themeModeInt;

  static Db get to => Get.find();

  Future<void> syncDb() async {
    prefs = await SharedPreferences.getInstance();
    updateDefaultPath(prefs.getString('subtitlePath'));
    themeModeInt = prefs.getInt('themeModeInt');
    changeThemeMode(themeModeInt);
  }

  void changeThemeMode(int? modeInt) {
    if (modeInt == 1) {
      Get.changeThemeMode(ThemeMode.light);
      themeModeInt = 1;
      prefs.setInt('themeModeInt', 1);
    } else if (modeInt == 2) {
      Get.changeThemeMode(ThemeMode.dark);
      themeModeInt = 2;
      prefs.setInt('themeModeInt', 2);
    } else {
      Get.changeThemeMode(ThemeMode.system);
      themeModeInt = 0;
      prefs.setInt('themeModeInt', 0);
    }
    update();
  }

  void updateDefaultPath(String? path) {
    defaultDirectoryPath = path;
    update();
  }
}