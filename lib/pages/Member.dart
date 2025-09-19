import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_1/config/config.dart';

class Member extends StatefulWidget {
  final int uid; // uid จาก login
  const Member({super.key, required this.uid});

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  String username = '';
  int userID = 0;
  String email = '';
  int money = 0;
  String tel = '';
  String url = '';
  Future<void>? loadUser; // nullable Future

  TextEditingController creditController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUser = fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      var config = await Configuration.getConfig();
      url = config['apiEndpoint'];

      final res = await http.get(Uri.parse('$url/user/${widget.uid}'));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data is List && data.isNotEmpty) {
          setState(() {
            username = data[0]['user_name'] ?? '';
            userID = data[0]['uid'] != null
                ? int.tryParse(data[0]['uid'].toString()) ?? 0
                : 0;
            email = data[0]['email'] ?? '';
            money = data[0]['money'] != null
                ? int.tryParse(data[0]['money'].toString()) ?? 0
                : 0;

            tel = data[0]['tel'] ?? '';
          });
        } else {
          dev.log('User not found');
        }
      } else {
        dev.log('Failed to load user: ${res.statusCode}');
      }
    } catch (e) {
      dev.log('Error fetching user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The app bar at the top of the screen.
      appBar: AppBar(
        title: const Text(
          'กลับสู่หน้าหลัก',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),

      // The main content of the page, contained in a SingleChildScrollView
      // to allow for scrolling if the content exceeds the screen height.
      body: SingleChildScrollView(
        child: Container(
          // Set the background color to match the design.
          color: Colors.redAccent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section for user profile info.
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // User profile icon.
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        // User details.
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$username',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('รหัสสมาชิก : $userID'),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // Lotto Cash section with balance and buttons.
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lotto Cash',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'คงเหลือ: $money บาท',
                              style: const TextStyle(fontSize: 18),
                            ),

                            // Top-up button.
                            ElevatedButton(
                              onPressed: showTopUpDialog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  246,
                                  96,
                                  88,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text(
                                'เติมเงิน',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        const Text(
                          'ข้อมูลสมาชิก',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ชื่อ: $username\nEmail: $email\n$tel',
                              style: const TextStyle(fontSize: 16),
                            ),
                            // Edit button.
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add your logic for the top-up button here.
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("แก้ใขข้อมูลของคุณ"),
                                        content: const Text(
                                          "กรอกข้อมูลลงในช่องที่ต้องการแก้ใข",
                                        ),
                                        actions: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                ),
                                                child: Text("ชื่อ"),
                                              ),
                                            ],
                                          ),
                                          TextField(
                                            // controller: userctl,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                ),
                                                child: Text("Email"),
                                              ),
                                            ],
                                          ),
                                          TextField(
                                            // controller: fullnamectl,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                ),
                                                child: Text("เบอร์โทรศัพท์"),
                                              ),
                                            ],
                                          ),
                                          TextField(
                                            // controller: Emailctl,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            child: TextButton(
                                              child: const Text("OK"),
                                              onPressed: () {
                                                // edit_user_info(context);
                                                // userctl.clear();
                                                // fullnamectl.clear();
                                                // Emailctl.clear();
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    246,
                                    96,
                                    88,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                ),
                                child: const Text(
                                  'แก้ไข',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        //
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),

      // Bottom navigation bar.
    );
  }

  // ฟังก์ชันแสดง Dialog เติมเงิน
  void showTopUpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("เติมเงิน"),
          content: TextField(
            controller: creditController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "จำนวนเงินที่ต้องการเติม",
            ),
          ),
          actions: [
            TextButton(
              child: const Text("ยกเลิก"),
              onPressed: () {
                creditController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("ตกลง"),
              onPressed: () async {
                int amount = int.tryParse(creditController.text) ?? 0;
                if (amount > 0) {
                  await topUp(amount); // เรียกฟังก์ชันเติมเงิน
                  Navigator.of(context).pop();
                  creditController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("กรุณากรอกจำนวนเงินที่ถูกต้อง"),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  // ฟังก์ชันเติมเงิน
  Future<void> topUp(int amount) async {
    try {
      final res = await http.post(
        Uri.parse('$url/user/topup/${widget.uid}'), // ต้องตรงกับ API ของคุณ
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': amount}),
      );

      if (res.statusCode == 200) {
        setState(() {
          money += amount; // อัปเดตยอดเงินใน UI
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("เติมเงินสำเร็จ $amount บาท")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("เติมเงินไม่สำเร็จ")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("เกิดข้อผิดพลาด: $e")));
    }
  }
}
