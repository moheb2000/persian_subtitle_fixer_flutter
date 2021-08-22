import 'package:flutter/material.dart';
import './src/app.dart';
import './src/resources/db.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  db.syncDb().then((_) => runApp(App()));
}