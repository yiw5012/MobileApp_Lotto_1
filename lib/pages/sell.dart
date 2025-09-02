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
      backgroundColor: Colors.redAccent,
      appBar: AppBar(title: Text("sell")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 9),
            child: Text(
              "คำสั่งซื้อของฉัน",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(8, 2, 8, 8),
              child: Container(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  child: DefaultTabController(
                    length: 4,
                    child: Column(
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(text: "ยังไม่ชำระ"),
                            Tab(text: 'รอตรวจสอบ'),
                            Tab(text: 'ไม่สำเร็จ'),
                            Tab(text: 'สำเร็จ'),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Container(
                                        child: Text(
                                          "ยังไม่มีรายการชำระ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Container(
                                        child: Text(
                                          "ยังไม่มีรายการตรวจสอบ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Container(
                                        child: Text(
                                          "ยังไม่มีรายการไม่สำเร็จ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Container(
                                        child: Text(
                                          "ยังไม่มีรายการสำเร็จ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Expanded(
                        //   child: TabBarView(
                        //     children: const [
                        //       Center(child: Text("รายการยังไม่ชำระ")),
                        //       Center(child: Text("รายการรอตรวจสอบ")),
                        //       Center(child: Text("รายการไม่สำเร็จ")),
                        //       Center(child: Text("รายการสำเร็จ")),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Icon button for "หน้าแรก" (Home)
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
            // Icon button for "คำสั่งซื้อ" (Orders)
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
            // Icon button for "ตะกร้า" (Cart)
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
            // Icon button for "สมาชิก" (Member)
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
      MaterialPageRoute(builder: (context) => HomePage()),
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
}
