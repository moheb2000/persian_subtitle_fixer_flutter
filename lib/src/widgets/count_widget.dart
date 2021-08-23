import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../languages/fa_lang.dart';
import '../logic/logic.dart';

class CountWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GetBuilder<Logic>(
          builder: (_) {
            return Visibility(
              visible: _.totalCount != _.fixedCount + _.ignoredCount,
              child: LinearProgressIndicator(
                value: _.totalCount != 0 ? (_.fixedCount + _.ignoredCount) / _.totalCount : 0,
              ),
            );
          },
        ),
        Container(
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
        ),
      ],
    );
  }
}
