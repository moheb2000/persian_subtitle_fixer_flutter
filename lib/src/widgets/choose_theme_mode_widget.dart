import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/db.dart';

class ChooseThemeModeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Db>(
      builder: (_) {
        return Column(
          children: [
            RadioListTile(
              value: 0,
              title: Text('system'.tr),
              groupValue: Db.to.themeModeInt,
              onChanged: (int? value) {
                Db.to.changeThemeMode(value);
              },
            ),
            RadioListTile(
              value: 1,
              title: Text('light'.tr),
              groupValue: Db.to.themeModeInt,
              onChanged: (int? value) {
                Db.to.changeThemeMode(value);
              },
            ),
            RadioListTile(
              value: 2,
              title: Text('dark'.tr),
              groupValue: Db.to.themeModeInt,
              onChanged: (int? value) {
                Db.to.changeThemeMode(value);
              },
            ),
          ],
        );
      },
    );
  }
}
