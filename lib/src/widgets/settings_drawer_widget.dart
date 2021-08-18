import 'dart:io';

import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../languages/fa_lang.dart';

class SettingsDrawerWidget extends StatefulWidget {
  @override
  _SettingsDrawerWidgetState createState() => _SettingsDrawerWidgetState();
}

class _SettingsDrawerWidgetState extends State<SettingsDrawerWidget> {
  late SharedPreferences prefs;

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
                Text(
                  FaLang.settingsTitle,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                separator(),
                Text(
                  FaLang.changeDefaultFolderSettings,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                separator(),
                FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
                    return TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: snapshot.hasData ? snapshot.data!.getString('subtitlePath') : '',
                        hintTextDirection: TextDirection.ltr,
                      ),
                    );
                  },
                ),
                separator(),
                ElevatedButton.icon(
                  onPressed: () async {
                    prefs = await SharedPreferences.getInstance();

                    Directory? defaultPathDirectory = await FolderPicker.pick(
                        allowFolderCreation: true,
                        context: context,
                        rootDirectory: Directory(FolderPicker.ROOTPATH),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))));

                    if (defaultPathDirectory != null) {
                      await prefs.setString(
                          'subtitlePath', defaultPathDirectory.path);
                    }
                    setState(() {});
                  },
                  icon: Icon(Icons.folder_rounded),
                  label: Text(FaLang.changeDefaultFolderSettings),
                ),
                separator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget separator() {
    return SizedBox(
      height: 16,
    );
  }
}
