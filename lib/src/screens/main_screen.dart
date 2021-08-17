import 'package:flutter/material.dart';
import '../widgets/choose_file_widget.dart';
import '../languages/fa_lang.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FaLang.mainScreenTitle),
      ),
      body: ChooseFileWidget(),
    );
  }
}