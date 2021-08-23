import 'dart:io';

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:get/get.dart';

import './main_screen.dart';
import '../resources/db.dart';
import '../widgets/choose_theme_mode_widget.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    final List<PageViewModel> listPagesViewModel = [
      PageViewModel(
        title: 'introOneTitle'.tr,
        body: 'introOneBody'.tr,
        image: Image.asset(
          'assets/images/welcome.png',
          height: 180,
        ),
      ),
      PageViewModel(
        title: 'introTwoTitle'.tr,
        body: 'introTwoBody'.tr,
        image: Image.asset(
          'assets/images/android.png',
          height: 180,
        ),
      ),
      PageViewModel(
        title: 'changeThemeModeSettings'.tr,
        bodyWidget: Column(
          children: [
            Text(
              'introThreeTitle'.tr,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            ChooseThemeModeWidget(),
          ],
        ),
        image: Image.asset(
          'assets/images/puzzle.png',
          height: 180,
        ),
      ),
      PageViewModel(
        title: 'introFourTitle'.tr,
        body: 'introFourBody'.tr,
        image: Image.asset(
          'assets/images/folder.png',
          height: 180,
        ),
        footer: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final Directory? chosenDirectory = await FolderPicker.pick(
                    allowFolderCreation: true,
                    context: context,
                    rootDirectory: Directory(FolderPicker.ROOTPATH),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))));

                if (chosenDirectory != null) {
                  db.prefs.setString('subtitlePath', chosenDirectory.path);
                  db.defaultDirectoryPath = chosenDirectory.path;
                  setState(() {});
                }
              },
              child: Text('chooseFolderButton'.tr),
            ),
            Text(
              db.defaultDirectoryPath ?? '',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    ];
    return IntroductionScreen(
      pages: listPagesViewModel,
      done: Text('done'.tr,
          style: TextStyle(fontWeight: FontWeight.w600)),
      next: Text('next'.tr),
      isTopSafeArea: true,
      onDone: () {
        if (db.defaultDirectoryPath != null) {
          Get.offAll(MainScreen());
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              content: Text('introAlertMessage'.tr),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text('introAlertButton'.tr),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
