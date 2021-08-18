import 'package:flutter/material.dart';
import '../widgets/choose_file_widget.dart';
import '../languages/fa_lang.dart';
import '../widgets/settings_drawer_widget.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FaLang.mainScreenTitle),
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: Icon(Icons.settings_rounded),
            ),
          ),
        ],
      ),
      body: ChooseFileWidget(),
      endDrawer: SettingsDrawerWidget(),
    );
  }
}
