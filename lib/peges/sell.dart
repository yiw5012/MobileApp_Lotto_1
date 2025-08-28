import 'package:flutter/material.dart';

class sell extends StatefulWidget {
  const sell({super.key});

  @override
  State<sell> createState() => _sellState();
}

class _sellState extends State<sell> {
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
                      children: const [
                        TabBar(
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
                              Center(child: Text("รายการยังไม่ชำระ")),
                              Center(child: Text("รายการรอตรวจสอบ")),
                              Center(child: Text("รายการไม่สำเร็จ")),
                              Center(child: Text("รายการสำเร็จ")),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
