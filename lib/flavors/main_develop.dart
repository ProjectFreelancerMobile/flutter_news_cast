import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../app/app_controller.dart';
import '../app/base_app_config.dart';
import '../app/my_app.dart';
import '../utils/http_overrides.dart';

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Get.put<AppController>(AppController()).init(Environment.dev);
  setupStatusBar();
  runApp(TravelApp());
}
