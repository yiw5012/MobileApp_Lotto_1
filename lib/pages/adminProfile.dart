import 'package:flutter/material.dart';

class Adminprofile extends StatefulWidget {
  int uid = 0;
  String? name;
  String? email;
  String? tel;
  int? roleId;

  Adminprofile({super.key, required this.uid, this.name, this.email, this.tel, this.roleId});

  @override
  State<Adminprofile> createState() => _AdminprofileState();
}

class _AdminprofileState extends State<Adminprofile> {
  String username = '';
  String email = '';
  String tel = '';
  int roleId = 0;
  String is_admin = '';
  int adminroleid = 0;

  @override
  void initState() {
    super.initState();
    getuserinfo();
    
  }
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
                children: [
                  TableRow(
                    children: [
                      const SizedBox(
                        child: Text(
                          "ชื่อ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      Text(username),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        "อีเมล์",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(email),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text(
                        "เบอร์โทร",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(tel),
                    ],
                  ),
                  const TableRow(
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

void getuserinfo() {
  setState(() {
    // If widget.name is null, use an empty string '' as the default.
    username = widget.name ?? '';
    email = widget.email ?? '';
    tel = widget.tel ?? '';
    adminroleid = widget.roleId ?? 0; // Use 0 or another default value for int
    if (adminroleid == 1) {
      is_admin = 'ผู้ดูแลระบบ';
    } else {
      is_admin = 'ผู้ใช้ทั่วไป';
    }
  });
}
}
