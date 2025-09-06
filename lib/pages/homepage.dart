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
  String lottoNumber = ""; // ค่าเริ่มต้น
  int _selectedIndex = 0; // เก็บ index ของ nav bar

  // ✅ รายการหน้า
  final List<Widget> _pages = [
    const HomeContent(), // หน้าแรก
    const Sell(),
    const Cartpage(),
    Member(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // แสดงหน้าที่เลือกอยู่

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // ให้แสดง label ครบทุกอัน
        currentIndex: _selectedIndex, // index ปัจจุบัน
        selectedItemColor: Colors.redAccent, // สีตอนเลือก
        unselectedItemColor: Colors.grey, // สีตอนยังไม่เลือก
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "หน้าแรก"),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_sharp),
            label: "ผลรางวัล",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "ลอตเตอรี่ ",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "สมาชิก"),
        ],
      ),
    );
  }
}

/// ✅ แยก UI ของหน้าแรกออกมา (เพื่อความเป็นระเบียบ)
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String lottoNumber = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.redAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
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
                    width: 280,
                    height: 180,
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              (lottoNumber.isEmpty ? "000000" : lottoNumber)
                                  .split('')
                                  .map(
                                    (digit) => Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
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
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: randLotto,
                              child: const Text('สุ่มหวย'),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: findLotto,
                              child: const Text('ค้นหาเลข'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Sell(),
                              ),
                            );
                          },
                          child: const Text('ตรวจสลากของคุณ'),
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
    );
  }

  void randLotto() {
    final random = Random();
    final newNumber = random.nextInt(1000000).toString().padLeft(6, '0');
    setState(() {
      lottoNumber = newNumber;
    });
  }

  void findLotto() {
    // TODO: ไว้ทำค้นหาเลขทีหลัง
  }
}
