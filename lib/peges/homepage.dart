import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('เนื้อหาหลัก')),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            IconButton(icon: Icon(Icons.home), onPressed: null),
            IconButton(icon: Icon(Icons.class_sharp), onPressed: null),
            IconButton(icon: Icon(Icons.navigation), onPressed: null),
            IconButton(icon: Icon(Icons.person), onPressed: null),
          ],
        ),
      ),
    );
  }
}
