import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../languages/fa_lang.dart';
import '../logic/logic.dart';

class CountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(FaLang.fixed),
                GetBuilder<Logic>(
                  builder: (_) {
                    return Text('${_.fixedCount}');
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(FaLang.unknownFormat),
                GetBuilder<Logic>(
                  builder: (_) {
                    return Text('${_.ignoredCount}');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
