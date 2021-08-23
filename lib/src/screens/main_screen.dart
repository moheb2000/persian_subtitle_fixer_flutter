import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/choose_file_widget.dart';
import '../widgets/settings_drawer_widget.dart';
import '../widgets/choose_zip_widget.dart';
import '../widgets/count_widget.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('mainScreenTitle'.tr),
          actions: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(Icons.settings_rounded),
              ),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.insert_drive_file),
                text: 'tabFile'.tr,
              ),
              Tab(
                icon: Icon(Icons.archive_rounded),
                text: 'tabZip'.tr,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ChooseFileWidget(),
            ChooseZipWidget(),
          ],
        ),
        endDrawer: SettingsDrawerWidget(),
        bottomNavigationBar: BottomAppBar(
          child: CountWidget(),
        ),
      ),
    );
  }
}
