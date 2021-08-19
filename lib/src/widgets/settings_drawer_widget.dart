import 'dart:io';

import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../languages/fa_lang.dart';
import '../resources/db.dart';

class SettingsDrawerWidget extends StatefulWidget {
  @override
  _SettingsDrawerWidgetState createState() => _SettingsDrawerWidgetState();
}

class _SettingsDrawerWidgetState extends State<SettingsDrawerWidget> {
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
                titleSettings(FaLang.settingsTitle),
                separator(),
                subtitleSettings(FaLang.changeDefaultFolderSettings),
                separator(),
                TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: db.defaultDirectoryPath ?? '',
                    hintTextDirection: TextDirection.ltr,
                  ),
                ),
                separator(),
                chooseFolderSettings(),
                separator(),
                titleSettings(FaLang.aboutTitle),
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

  Widget chooseFolderSettings() {
    return ElevatedButton.icon(
      onPressed: () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        final Directory? chosenDirectory = await FolderPicker.pick(
            allowFolderCreation: true,
            context: context,
            rootDirectory: db.defaultDirectoryPath != null
                ? Directory(db.defaultDirectoryPath!)
                : Directory(FolderPicker.ROOTPATH),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))));

        if (chosenDirectory != null) {
          prefs.setString('subtitlePath', chosenDirectory.path);
          db.defaultDirectoryPath = chosenDirectory.path;
          setState(() {});
        }
      },
      icon: Icon(Icons.folder_rounded),
      label: Text(FaLang.changeDefaultFolderSettings),
    );
  }

  Widget about() {
    return Container(
      alignment: Alignment.topRight,
      child: Column(
        children: [
          Text('توسعه دهنده: محمد ابراهیمی'),
        ],
      ),
    );
  }

  Widget separator() {
    return SizedBox(
      height: 16,
    );
  }
}
