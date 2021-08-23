import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:archive/archive.dart';
import 'package:get/get.dart';

import './windows1256_persian.dart';
import '../resources/db.dart';

class Logic extends GetxController {
  int fixedCount = 0;
  int ignoredCount = 0;
  int totalCount = 0;
  bool inactiveButtons = false;
  List<String> supportedExtensions = ['ass', 'srt'];
  List<PlatformFile>? filesList;
  List<PlatformFile>? zipsList;

  static Logic get to => Get.find();

  Future<void> fixSubtitleFile(List<PlatformFile> files) async {
    inactiveButtons = true;
    fixedCount = 0;
    ignoredCount = 0;
    totalCount = files.length;
    update();
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
            await File('${Db.to.defaultDirectoryPath}/[Fixed]${file.name}')
                .create(recursive: true);
        lestFile.writeAsString(fixedString);
        fixedCount++;
      } else {
        ignoredCount++;
      }
      update();
    }
    inactiveButtons = false;
    filesList = null;
    update();
  }

  Future<void> fixSubtitleZip(List<PlatformFile> zips) async {
    inactiveButtons = true;
    fixedCount = 0;
    ignoredCount = 0;
    totalCount = 0;
    for (var zip in zips) {
      final List<int> zipBytes = await File(zip.path!).readAsBytes();
      final Archive archive = ZipDecoder().decodeBytes(zipBytes);
      for (var file in archive) {
        if(file.isFile) {
          totalCount++;
        }
      }
    }
    update();
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
            await File('${Db.to.defaultDirectoryPath}/$zipName/[Fixed]${file.name}')
                .create(recursive: true);
            lestFile.writeAsString(fixedString);
            fixedCount++;
          } else {
            ignoredCount++;
          }
        }
        update();
      }
    }
    inactiveButtons = false;
    zipsList = null;
    update();
  }

  void updateFiles(List<PlatformFile> files) {
    filesList = files;
    update();
  }

  void updateZips(List<PlatformFile> files) {
    zipsList = files;
    update();
  }
}
