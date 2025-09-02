import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lotto_1/pages/Member.dart';
import 'package:lotto_1/pages/cart.dart';
import 'package:lotto_1/pages/sell.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String lottoNumber = "------"; // ค่าเริ่มต้น

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.redAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'ลอตเตอรี่',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'งวดวันที่ 16 สิงหาคม 2568',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // ✅ แสดงเลขที่สุ่มได้
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 250,
                      height: 150,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: lottoNumber
                                .split('')
                                .map(
                                  (digit) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      color: Colors.blue,
                                      alignment: Alignment.center,
                                      child: Text(
                                        digit,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: randLotto,
                                  child: const Text('สุ่มหวย'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: FindLotto,
                                  child: const Text('ค้นหาเลข'),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: sell,
                              child: const Text('ตรวจสลากของคุณ'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Bottom nav bar
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: home,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.home),
                  Text('หน้าแรก', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            TextButton(
              onPressed: sell,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.class_sharp),
                  Text('คำสั่งซื้อ', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            TextButton(
              onPressed: cart,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.shopping_cart),
                  Text('ตะกร้า', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            TextButton(
              onPressed: member,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.person),
                  Text('สมาชิก', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void home() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void member() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Member()));
  }

  void sell() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Sell()),
    );
  }

  void cart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Cartpage()),
    );
  }

  void randLotto() {
    final random = Random();
    final newNumber = random.nextInt(1000000).toString().padLeft(6, '0');
    setState(() {
      lottoNumber = newNumber;
    });
  }

  void FindLotto() {
    // ไว้ทำค้นหาเลขทีหลัง
  }
}
