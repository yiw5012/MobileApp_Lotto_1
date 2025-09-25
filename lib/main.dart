import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:lotto_1/apptheme/appthem.dart';
import 'package:lotto_1/pages/homepage.dart';
import 'package:lotto_1/pages/login.dart';
// ใช้สำหรับโค้ด `Intl.defaultLocale = "th";`
import 'package:intl/intl.dart';
// ใช้สำหรับโค้ด initializeDateFormatting()
import 'package:intl/date_symbol_data_local.dart';

void main() {
  Intl.defaultLocale = "th";
  initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Lotto',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: LoginPeges(),
    );
  }
}
