import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_1/config/config.dart';
import 'package:lotto_1/model/response/Lotto_get_respon.dart';
import 'package:lotto_1/model/response/Order_get_respon.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  String url = '';
  late Future<void> loadData;
  List<OrderGetResponse> orderGetRespon = [];

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- แถบขั้นตอน ---
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.pinkAccent, Colors.red]),
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

          // --- FutureBuilder ---
          Expanded(
            child: FutureBuilder(
              future: loadData,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (orderGetRespon.isEmpty) {
                  return const Center(child: Text("ไม่พบลอตเตอรี่"));
                }

                return ListView(
                  children: orderGetRespon.map((order) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // --- เนื้อหาใน Card ---
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // --- แถว เลขสลาก + เวลา ---
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(order.lottoNumber.toString()),
                                    Text(
                                      order.lottoNumber.toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 6),

                                // --- ราคา ---
                                Text(
                                  order.price.toString(),
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
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
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
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadDataAsync() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var res = await http.get(Uri.parse('$url/order/$1'));
    log(res.body);
    setState(() {
      orderGetRespon = orderGetResponseFromMap(res.body);
    });
  }
}
