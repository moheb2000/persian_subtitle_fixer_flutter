import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import './main_screen.dart';
import '../resources/db.dart';
import '../widgets/choose_theme_mode_widget.dart';
import '../widgets/choose_locale_widget.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<PageViewModel> listPagesViewModel = [
      PageViewModel(
        title: 'introOneTitle'.tr,
        bodyWidget: Column(
          children: [
            Text(
              'introOneBody'.tr,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            ChooseLocaleWidget(),
          ],
        ),
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
                final String? chosenDirectory = await FilePicker.platform.getDirectoryPath();

                if (chosenDirectory != null) {
                  Db.to.prefs.setString('subtitlePath', chosenDirectory);
                  Db.to.updateDefaultPath(chosenDirectory);
                }
              },
              child: Text('chooseFolderButton'.tr),
            ),
            GetBuilder<Db>(
              builder: (_) {
                return Text(
                  _.defaultDirectoryPath ?? '',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                );
              },
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
        if (Db.to.defaultDirectoryPath != null) {
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
