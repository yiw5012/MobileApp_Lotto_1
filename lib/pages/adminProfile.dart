import 'package:flutter/material.dart';

class Adminprofile extends StatefulWidget {
  const Adminprofile({super.key});

  @override
  State<Adminprofile> createState() => _AdminprofileState();
}

class _AdminprofileState extends State<Adminprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(title: Text('Admin Profile')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Center(
              child: Text(
                "ข้อมูลผู้ดูแลระบบ",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // กล่องด้านในสีขาว
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(18),
              child: Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(
                    flex: 0.3,
                  ), // คอลัมน์ label กว้างตามเนื้อหา
                  1: FlexColumnWidth(), // คอลัมน์ value ขยายเต็ม
                },
                children: const [
                  TableRow(
                    children: [
                      SizedBox(
                        child: Text(
                          "ชื่อ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      Text("Lotto"),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        "อีเมล์",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("Lotto@l.com"),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        "เบอร์โทร",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("09xxxxxxxx"),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        "สถานะ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("ผู้ดูแลระบบ"),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Card(
          //   child: Padding(
          //     padding: const EdgeInsets.all(12.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         infoRow("ชื่อ", "Lotto"),
          //         infoRow("อีเมล์", "Lotto@l.com"),
          //         infoRow("เบอร์โทร", "09xxxxxxxx"),
          //         infoRow("สถานะ", "ผู้ดูแลระบบ"),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 20))),
        ],
      ),
    );
  }
}
