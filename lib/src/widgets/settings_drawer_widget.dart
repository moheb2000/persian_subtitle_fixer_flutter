import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

import '../resources/db.dart';
import './choose_theme_mode_widget.dart';
import './choose_locale_widget.dart';

class SettingsDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            child: Column(
              children: [
                separator(),
                titleSettings('settingsTitle'.tr),
                separator(),
                subtitleSettings('changeDefaultFolderSettings'.tr),
                separator(),
                GetBuilder<Db>(
                  builder: (_) {
                    return TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: _.defaultDirectoryPath ?? '',
                        hintTextDirection: TextDirection.ltr,
                      ),
                    );
                  },
                ),
                separator(),
                chooseFolderSettings(context),
                separator(),
                subtitleSettings('changeThemeModeSettings'.tr),
                separator(),
                ChooseThemeModeWidget(),
                separator(),
                subtitleSettings('languageTitle'.tr),
                separator(),
                ChooseLocaleWidget(),
                separator(),
                titleSettings('aboutTitle'.tr),
                separator(),
                about(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleSettings(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
      ),
    );
  }

  Widget subtitleSettings(String subtitle) {
    return Text(
      subtitle,
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  Widget chooseFolderSettings(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final String? chosenDirectory = await FilePicker.platform.getDirectoryPath();

        if (chosenDirectory != null) {
          Db.to.prefs.setString('subtitlePath', chosenDirectory);
          Db.to.updateDefaultPath(chosenDirectory);
        }
      },
      icon: Icon(Icons.folder_rounded),
      label: Text('changeDefaultFolderSettings'.tr),
    );
  }

  Widget about() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'aboutDeveloper'.tr,
        ),
        separator8(),
        Text(
          'aboutVersion'.tr,
        ),
        separator8(),
        Text(
          'aboutLicense'.tr,
        ),
        separator8(),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  launchURL('githubLink'.tr);
                },
                child: Text('githubText'.tr),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  launchURL('bugReportLink'.tr);
                },
                child: Text('bugReportText'.tr),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget separator() {
    return SizedBox(
      height: 16,
    );
  }

  Widget separator8() {
    return SizedBox(
      height: 8,
    );
  }

  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
