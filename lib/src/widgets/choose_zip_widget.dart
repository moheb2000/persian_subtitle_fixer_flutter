import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../languages/fa_lang.dart';
import '../logic/logic.dart';

class ChooseZipWidget extends StatefulWidget {
  @override
  _ChooseZipWidgetState createState() => _ChooseZipWidgetState();
}

class _ChooseZipWidgetState extends State<ChooseZipWidget> {
  List<PlatformFile>? zips;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            multipleZipChooseHint(),
            separator(),
            chooseZipButton(),
            separator(),
            fixButton(),
            separator(),
            listOfZips(),
          ],
        ),
      ),
    );
  }

  Widget chooseZipButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final FilePickerResult? chosenZips = await FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ['zip', 'tar'],
          );
          if (chosenZips != null) {
            zips = chosenZips.files;
            setState(() {});
          }
        },
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            FaLang.chooseZipButton,
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
        onPressed: zips == null
            ? null
            : () async {
          final PermissionStatus status = await Permission.storage.status;
          if (status.isDenied) {
            Permission.storage.request();
          }
          Logic.to.fixSubtitleZip(zips!).then((_) {
            zips = null;
            setState(() {});
          });
        },
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

  Widget multipleZipChooseHint() {
    return Text(
      FaLang.multipleFileChooseHint,
    );
  }

  Widget listOfZips() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: zips != null ? zips!.length : 1,
      itemBuilder: (context, int index) {
        if (zips == null) {
          return Text('');
        } else {
          return Text(
            zips![index].name,
            textDirection: TextDirection.ltr,
            style: TextStyle(
              color: Colors.grey,
            ),
          );
        }
      },
    );
  }

  Widget separator() {
    return SizedBox(
      height: 8,
    );
  }
}
