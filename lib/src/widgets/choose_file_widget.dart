import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../languages/fa_lang.dart';
import '../logic/logic.dart';

class ChooseFileWidget extends StatefulWidget {
  @override
  _ChooseFileWidgetState createState() => _ChooseFileWidgetState();
}

class _ChooseFileWidgetState extends State<ChooseFileWidget> with Logic {
  FilePickerResult? result;
  List<PlatformFile>? files;

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
        onPressed: () async {
          result = await FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.custom,
            allowedExtensions: ['srt', 'ass'],
          );
          if (result != null) {
            files = result!.files;
          }
          setState(() {});
        },
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
        onPressed: files == null ? null : () async {
          PermissionStatus status = await Permission.storage.status;
          if (status.isDenied) {
            Permission.storage.request();
          }
          fixSubtitleFile(files!);
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

  Widget multipleFileChooseHint() {
    return Text(
      FaLang.multipleFileChooseHint,
    );
  }

  Widget listOfFiles() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: files != null ? files!.length : 1,
      itemBuilder: (context, int index) {
        if (files == null) {
          return Text('');
        } else {
          return Text(
            files![index].name,
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
