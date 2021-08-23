import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../logic/logic.dart';

class ChooseFileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            multipleFileChooseHint(),
            separator(),
            chooseFileButton(),
            separator(),
            fixButton(),
            separator(),
            listOfFiles(),
          ],
        ),
      ),
    );
  }

  Widget chooseFileButton() {
    return Container(
      width: double.infinity,
      child: GetBuilder<Logic>(
        builder: (_) {
          return ElevatedButton(
            onPressed: _.inactiveButtons ? null : () async {
              final FilePickerResult? chosenFiles = await FilePicker.platform.pickFiles(
                allowMultiple: true,
                type: FileType.any,
              );
              if (chosenFiles != null) {
                Logic.to.updateFiles(chosenFiles.files);
              }
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'chooseFileButton'.tr,
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
            onPressed: _.filesList == null || _.inactiveButtons
                ? null
                : () async {
              final PermissionStatus manageExternalStorageStatus = await Permission.manageExternalStorage.status;
              if (manageExternalStorageStatus.isDenied) {
                await Permission.manageExternalStorage.request();
              }
              final PermissionStatus storageStatus = await Permission.storage.status;
              if (storageStatus.isDenied) {
                await Permission.storage.request();
              }
              Logic.to.fixSubtitleFile(_.filesList!);
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

  Widget multipleFileChooseHint() {
    return Text(
      'multipleFileChooseHint'.tr,
    );
  }

  Widget listOfFiles() {
    return GetBuilder<Logic>(
        builder: (_) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: _.filesList != null ? _.filesList!.length : 1,
            itemBuilder: (context, int index) {
              if (_.filesList == null) {
                return Text('');
              } else {
                return Text(
                  _.filesList![index].name,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                );
              }
            },
          );
        },
    );
  }

  Widget separator() {
    return SizedBox(
      height: 8,
    );
  }
}
