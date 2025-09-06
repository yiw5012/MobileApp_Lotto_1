import 'package:flutter/material.dart';
import 'package:lotto_1/pages/Member.dart';
import 'package:lotto_1/pages/cart.dart';
import 'package:lotto_1/pages/homepage.dart';

class Sell extends StatefulWidget {
  const Sell({super.key});

  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---------- AppBar ----------
      appBar: AppBar(title: const Text("กลับสู่หน้าหลัก"), centerTitle: false),

      // ---------- Body ----------
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Header ---
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.red],
                ),
              ),
              child: const Column(
                children: [
                  Text(
                    "รางวัลลอตเตอรี่",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 6),
                  Text(
                    "งวดวันที่ 16 สิงหาคม",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // --- Card รางวัลที่ 1 ---
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    // --- ชื่อรางวัล ---
                    Text(
                      "รางวัลที่ 1",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 6),

                    // --- เงินรางวัล ---
                    Text(
                      "เงินรางวัล 5,000,000 บาท",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 12),

                    // --- เลขที่ถูกรางวัล ---
                    Center(
                      child: Text(
                        "123456",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 91, 253, 3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
