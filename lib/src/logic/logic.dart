import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:enough_convert/enough_convert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logic {
  void fixSubtitleFile(List<PlatformFile> files) async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    for (var file in files) {
      final List<int> firstFile = await File(file.path!).readAsBytes();
      final String fixedString = Windows1256Codec().decode(firstFile);
      final lestFile = await File('${pres.getString('subtitlePath')}/[Fixed]${file.name}').create(recursive: true);
      lestFile.writeAsString(fixedString);
    }
  }
}