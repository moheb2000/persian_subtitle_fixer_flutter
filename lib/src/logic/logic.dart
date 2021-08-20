import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:archive/archive.dart';

import './windows1256_persian.dart';

class Logic {
  int fixedCount = 0;
  int ignoredCount = 0;
  List<String> supportedExtensions = ['ass', 'srt'];

  Future<int> fixSubtitleFile(List<PlatformFile> files) async {
    fixedCount = 0;
    ignoredCount = 0;
    SharedPreferences pres = await SharedPreferences.getInstance();
    for (var file in files) {
      if (supportedExtensions.contains(file.extension)) {
        final List<int> firstFile = await File(file.path!).readAsBytes();
        late final String fixedString;
        try {
          fixedString = utf8.decode(firstFile);
        } catch (e) {
          fixedString = Windows1256PersianCodec().decode(firstFile);
        }
        final lestFile =
            await File('${pres.getString('subtitlePath')}/[Fixed]${file.name}')
                .create(recursive: true);
        lestFile.writeAsString(fixedString);
        fixedCount++;
      } else {
        ignoredCount++;
      }
    }

    return 0;
  }

  Future<int> fixSubtitleZip(List<PlatformFile> zips) async {
    fixedCount = 0;
    ignoredCount = 0;
    SharedPreferences pres = await SharedPreferences.getInstance();
    for (var zip in zips) {
      final String zipName = zip.name.split('.').first;
      final List<int> zipBytes = await File(zip.path!).readAsBytes();
      final Archive archive = ZipDecoder().decodeBytes(zipBytes);
      for (var file in archive) {
        if (file.isFile) {
          if (supportedExtensions.contains(file.name.split('.').last)) {
            final data = file.content as List<int>;
            late final String fixedString;
            try {
              fixedString = utf8.decode(data);
            } catch (e) {
              fixedString = Windows1256PersianCodec().decode(data);
            }
            final lestFile =
            await File('${pres.getString('subtitlePath')}/$zipName/[Fixed]${file.name}')
                .create(recursive: true);
            lestFile.writeAsString(fixedString);
            fixedCount++;
          } else {
            ignoredCount++;
          }
        }
      }
    }
    return 0;
  }
}
