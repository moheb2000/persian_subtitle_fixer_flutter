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
          value: ThemeMode.system,
          title: Text(FaLang.system),
          groupValue: db.themeModeNotifier.value,
          onChanged: (ThemeMode? value) {
            db.themeModeNotifier.value = value!;
            db.prefs.setInt('themeModeInt', 0);
            setState(() {});
          },
        ),
        RadioListTile(
          value: ThemeMode.light,
          title: Text(FaLang.light),
          groupValue: db.themeModeNotifier.value,
          onChanged: (ThemeMode? value) {
            db.themeModeNotifier.value = value!;
            db.prefs.setInt('themeModeInt', 1);
            setState(() {});
          },
        ),
        RadioListTile(
          value: ThemeMode.dark,
          title: Text(FaLang.dark),
          groupValue: db.themeModeNotifier.value,
          onChanged: (ThemeMode? value) {
            db.themeModeNotifier.value = value!;
            db.prefs.setInt('themeModeInt', 2);
            setState(() {});
          },
        ),
      ],
    );
  }
}
