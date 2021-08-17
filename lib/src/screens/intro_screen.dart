import 'dart:io';

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../languages/fa_lang.dart';
import './main_screen.dart';

class IntroScreen extends StatelessWidget {
  late List<PageViewModel> listPagesViewModel;
  late SharedPreferences prefs;
  Directory? newDirectory;

  @override
  Widget build(BuildContext context) {
    listPagesViewModel = [
      PageViewModel(
        title: FaLang.introOneTitle,
        body: FaLang.introOneBody,
      ),
      PageViewModel(
        title: FaLang.introThreeTitle,
        body: FaLang.introThreeBody,
        footer: ElevatedButton(
          onPressed: () async {
            prefs = await SharedPreferences.getInstance();

            Directory? newDirectory = await FolderPicker.pick(
                allowFolderCreation: true,
                context: context,
                rootDirectory: Directory(FolderPicker.ROOTPATH),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))));

            if (newDirectory != null) {
              await prefs.setString('subtitlePath', newDirectory.path);
            }
          },
          child: Text(FaLang.chooseFolderButton),
        ),
      ),
    ];
    return IntroductionScreen(
      pages: listPagesViewModel,
      done: const Text(FaLang.done,
          style: TextStyle(fontWeight: FontWeight.w600)),
      next: Text(FaLang.next),
      isTopSafeArea: true,
      onDone: () async {
        prefs = await SharedPreferences.getInstance();

        if (prefs.getString('subtitlePath') != null) {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) => MainScreen()));
        } else {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              content: const Text('قبل از ادامه کار شما باید مجوز دسترسی را تایید کنید و دایرکتوری پیشفرض زیرنویس ها را نیز انتخاب نمایید'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, null),
                  child: const Text('باشه'),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
