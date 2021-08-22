import 'package:flutter/material.dart';

import '../languages/fa_lang.dart';
import '../resources/db.dart';

class ChooseThemeModeWidget extends StatefulWidget {
  @override
  _ChooseThemeModeWidgetState createState() => _ChooseThemeModeWidgetState();
}

class _ChooseThemeModeWidgetState extends State<ChooseThemeModeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          value: 0,
          title: Text(FaLang.system),
          groupValue: db.themeModeInt,
          onChanged: (int? value) {
            db.changeThemeMode(value);
            setState(() {});
          },
        ),
        RadioListTile(
          value: 1,
          title: Text(FaLang.light),
          groupValue: db.themeModeInt,
          onChanged: (int? value) {
            db.changeThemeMode(value);
            setState(() {});
          },
        ),
        RadioListTile(
          value: 2,
          title: Text(FaLang.dark),
          groupValue: db.themeModeInt,
          onChanged: (int? value) {
            db.changeThemeMode(value);
            setState(() {});
          },
        ),
      ],
    );
  }
}
