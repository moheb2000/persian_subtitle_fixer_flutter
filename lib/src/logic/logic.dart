import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:enough_convert/enough_convert.dart';
import 'package:path_provider/path_provider.dart';

class Logic {
  void fixSubtitleFile(List<PlatformFile> files) async {
    Directory? exDirectory = await getExternalStorageDirectory();
    for (var file in files) {
      final List<int> firstFile = await File(file.path!).readAsBytes();
      final String fixedString = Windows1256Codec().decode(firstFile);
      await File('${exDirectory!.path}/[Fixed]${file.name}').writeAsString(fixedString);
    }
  }
}