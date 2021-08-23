import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './src/app.dart';
import './src/resources/db.dart';

void main() {
  Get.put(Db());

  WidgetsFlutterBinding.ensureInitialized();
  Db.to.syncDb().then((_) => runApp(App()));
}