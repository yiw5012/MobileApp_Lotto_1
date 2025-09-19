import 'package:flutter/material.dart';
import 'package:lotto_1/apptheme/appthem.dart';
import 'package:lotto_1/pages/homepage.dart';
import 'package:lotto_1/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotto',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: LoginPeges(),
    );
  }
}
