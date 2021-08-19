import 'package:shared_preferences/shared_preferences.dart';

class Db {
  String? defaultDirectoryPath;
  Future<String?> syncDb() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    defaultDirectoryPath = prefs.getString('subtitlePath');
    return defaultDirectoryPath;
  }
}

Db db = new Db();