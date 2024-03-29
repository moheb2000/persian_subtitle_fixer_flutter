import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../logic/logic.dart';

class ChooseZipWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            multipleZipChooseHint(),
            separator(),
            chooseZipButton(),
            separator(),
            fixButton(),
            separator(),
            listOfZips(),
          ],
        ),
      ),
    );
  }

  Widget chooseZipButton() {
    return Container(
      width: double.infinity,
      child: GetBuilder<Logic>(
        builder: (_) {
          return ElevatedButton(
            onPressed: _.inactiveButtons
                ? null
                : () async {
                    final FilePickerResult? chosenZips =
                        await FilePicker.platform.pickFiles(
                      allowMultiple: true,
                      type: FileType.custom,
                      allowedExtensions: ['zip', 'tar'],
                    );
                    if (chosenZips != null) {
                      Logic.to.updateZips(chosenZips.files);
                    }
                  },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'chooseZipButton'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget fixButton() {
    return Container(
      width: double.infinity,
      child: GetBuilder<Logic>(
        builder: (_) {
          return ElevatedButton(
            onPressed: _.zipsList == null || _.inactiveButtons
                ? null
                : () async {
                    final PermissionStatus manageExternalStorageStatus =
                        await Permission.manageExternalStorage.status;
                    if (manageExternalStorageStatus.isDenied) {
                      await Permission.manageExternalStorage.request();
                    }
                    final PermissionStatus storageStatus =
                        await Permission.storage.status;
                    if (storageStatus.isDenied) {
                      await Permission.storage.request();
                    }
                    Logic.to.fixSubtitleZip(_.zipsList!);
                  },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'fixButton'.tr,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget multipleZipChooseHint() {
    return Text(
      'multipleZipChooseHint'.tr,
    );
  }

  Widget listOfZips() {
    return GetBuilder<Logic>(
      builder: (_) {
        if (_.zipsList != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
              _.zipsList!.length,
              (index) {
                return Text(
                  _.zipsList![index].name,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                );
              },
            ),
          );
        } else {
          return Text('');
        }
      },
    );
  }

  Widget separator() {
    return SizedBox(
      height: 8,
    );
  }
}
