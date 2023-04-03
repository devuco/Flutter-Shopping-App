import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/screens/splash.dart';
import 'package:my_app/utils/Messages.dart';

void main() async {
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(GetMaterialApp(
    translations: Messages(),
    locale: const Locale('en', 'US'),
    home: const Splash(),
  ));
}
