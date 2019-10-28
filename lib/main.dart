import 'package:flutter/material.dart';
import 'package:pilot_log/src/FlutterApp.dart';

import 'package:pilot_log/src/services/appInitialization.dart';

void main() {
  AppInitialization.initializeApp();

  runApp(FlutterApp());
}
