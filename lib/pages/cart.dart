import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_1/config/config.dart';
import 'package:lotto_1/model/response/Lotto_get_respon.dart';
import 'package:lotto_1/pages/Member.dart';
import 'package:lotto_1/pages/homepage.dart';
import 'package:lotto_1/pages/sell.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  String url = '';
  late Future<void> loadData;
  List<LottoGetRespon> lottoGetRespon = [];
  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
  }

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
            // --- แถบขั้นตอน ---
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.red],
                ),
              ),
              child: const Text(
                "ลอตเตอรี่ของคุณ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 10),

            // --- Card ลอตเตอรี่ ---
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- รูปภาพ (ใส่ทีหลังได้) ---
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                  ),

                  // --- เนื้อหาใน Card ---
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- แถว เลขสลาก + เวลา ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "#123456",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "22/08/2025, 02:37 PM",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),

                        // --- ราคา ---
                        const Text(
                          "80 บาท",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 0),

                        // --- ปุ่มตรวจหวย ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, // สีพื้นหลังปุ่ม
                                foregroundColor: Colors.white, // สีตัวหนังสือ
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("ตรวจหวย"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadDataAsync() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var res = await http.get(Uri.parse('$url/lotto'));
    log(res.body);
  }
}
