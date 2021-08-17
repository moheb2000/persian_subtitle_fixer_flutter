import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../languages/fa_lang.dart';

class ChooseFileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            multipleFileChooseHint(),
            separator(),
            chooseFileButton(),
            separator(),
            fixButton(),
            separator(),
            listOfFiles(),
          ],
        ),
      ),
    );
  }

  Widget chooseFileButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            FaLang.chooseFileButton,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget fixButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: null,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            FaLang.fixButton,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget multipleFileChooseHint() {
    return Text(
      FaLang.multipleFileChooseHint,
    );
  }

  Widget listOfFiles() {
    return Text('');
  }

  Widget separator() {
    return SizedBox(
      height: 8,
    );
  }
}
