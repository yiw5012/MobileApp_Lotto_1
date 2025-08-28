import 'package:flutter/material.dart';
import 'package:lotto_1/peges/Member.dart';
import 'package:lotto_1/peges/homepage.dart';
import 'package:lotto_1/peges/login.dart';
import 'package:lotto_1/peges/sell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter Demo', home: sell());
  }
}
