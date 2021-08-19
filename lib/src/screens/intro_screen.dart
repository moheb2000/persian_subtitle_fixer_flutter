import 'dart:io';

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../languages/fa_lang.dart';
import './main_screen.dart';
import '../resources/db.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    final List<PageViewModel> listPagesViewModel = [
      PageViewModel(
        title: FaLang.introOneTitle,
        body: FaLang.introOneBody,
        image: Image.asset(
          'assets/images/welcome.png',
          height: 180,
        ),
      ),
      PageViewModel(
        title: FaLang.introTwoTitle,
        body: FaLang.introTwoBody,
        image: Image.asset(
          'assets/images/puzzle.png',
          height: 180,
        ),
      ),
      PageViewModel(
        title: FaLang.introThreeTitle,
        body: FaLang.introThreeBody,
        image: Image.asset(
          'assets/images/android.png',
          height: 180,
        ),
      ),
      PageViewModel(
        title: FaLang.introFourTitle,
        body: FaLang.introFourBody,
        image: Image.asset(
          'assets/images/folder.png',
          height: 180,
        ),
        footer: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final SharedPreferences prefs = await SharedPreferences.getInstance();

                final Directory? chosenDirectory = await FolderPicker.pick(
                    allowFolderCreation: true,
                    context: context,
                    rootDirectory: Directory(FolderPicker.ROOTPATH),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))));

                if (chosenDirectory != null) {
                  prefs.setString(
                      'subtitlePath', chosenDirectory.path);
                  db.defaultDirectoryPath = chosenDirectory.path;
                  setState(() {});
                }
              },
              child: Text(FaLang.chooseFolderButton),
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
      done: const Text(FaLang.done,
          style: TextStyle(fontWeight: FontWeight.w600)),
      next: Text(FaLang.next),
      isTopSafeArea: true,
      onDone: () {
        if (db.defaultDirectoryPath != null) {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) => MainScreen()));
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              content: const Text(FaLang.introAlertMessage),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: const Text(FaLang.introAlertButton),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
