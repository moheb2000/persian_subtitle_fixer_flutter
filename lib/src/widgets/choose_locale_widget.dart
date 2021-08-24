import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/db.dart';

class ChooseLocaleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Db>(
      builder: (_) {
        return Column(
          children: [
            RadioListTile(
              value: 0,
              title: Text('persian'.tr),
              groupValue: Db.to.localeInt,
              onChanged: (int? value) {
                Db.to.changeAppLocale(value);
              },
            ),
            RadioListTile(
              value: 1,
              title: Text('english'.tr),
              groupValue: Db.to.localeInt,
              onChanged: (int? value) {
                Db.to.changeAppLocale(value);
              },
            ),
          ],
        );
      },
    );
  }
}