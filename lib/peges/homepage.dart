import 'package:flutter/material.dart';
import 'package:lotto_1/peges/cart.dart';

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
          children: [
            IconButton(icon: const Icon(Icons.home), onPressed: () {}),
            IconButton(icon: const Icon(Icons.class_sharp), onPressed: () {}),
            IconButton(icon: const Icon(Icons.navigation), onPressed: cart),
            IconButton(icon: const Icon(Icons.person), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  void cart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Cartpage()),
    );
  }
}
