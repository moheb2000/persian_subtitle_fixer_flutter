import 'package:shared_preferences/shared_preferences.dart';

class Db {
  String? defaultDirectoryPath;
  late SharedPreferences prefs;
  Future<String?> syncDb() async {
    prefs = await SharedPreferences.getInstance();
    defaultDirectoryPath = prefs.getString('subtitlePath');
    return defaultDirectoryPath;
  }
}

Db db = new Db();