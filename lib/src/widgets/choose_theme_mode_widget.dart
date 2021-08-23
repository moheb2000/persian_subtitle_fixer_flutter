import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          title: Text('system'.tr),
          groupValue: db.themeModeInt,
          onChanged: (int? value) {
            db.changeThemeMode(value);
            setState(() {});
          },
        ),
        RadioListTile(
          value: 1,
          title: Text('light'.tr),
          groupValue: db.themeModeInt,
          onChanged: (int? value) {
            db.changeThemeMode(value);
            setState(() {});
          },
        ),
        RadioListTile(
          value: 2,
          title: Text('dark'.tr),
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
