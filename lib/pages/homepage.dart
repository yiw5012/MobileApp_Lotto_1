import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_1/config/config.dart';
import 'package:lotto_1/model/response/lottolist_get_res.dart';
import 'package:lotto_1/pages/Member.dart';
import 'package:lotto_1/pages/cart.dart';
import 'package:lotto_1/pages/sell.dart';

class HomePage extends StatefulWidget {
  final int uid;

  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String lottoNumber = ""; // ค่าเริ่มต้น
  int _selectedIndex = 0; // เก็บ index ของ nav bar
  late List<Widget> _pages;

  String url = '';

  // ✅ รายการหน้า
  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(user: widget.uid), // หน้าแรก
      const Sell(),
      Cartpage(uid: widget.uid),
      Member(uid: widget.uid),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
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
  int user = 0;
  HomeContent({super.key, required this.user});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String url = '';
  late Future<void> loaddata;
  String lottoNumber = "";
  late List<LottoListGetRes> lottoListGetRes = [];

  TextEditingController l6 = TextEditingController();
  // final ConfigController config = Get.put(ConfigController()); //ดึงค่า
  @override
  void initState() {
    super.initState();
    dev.log("HomeContent initState called");
    loaddata = loaddatLotto();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loaddata,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        dev.log(lottoListGetRes.length.toString());

        return Column(
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
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    // width: 280,
                    // height: 180,
                    child: SingleChildScrollView(
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
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(6),
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
                                          ],
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
                                onPressed: () => findLotto(lottoNumber),
                                child: const Text('ค้นหาเลข'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Get.to(Sell());
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const Sell(),
                              //   ),
                              // );
                            },
                            child: const Text('ตรวจสลากของคุณ'),
                          ),
                          Column(
                            children: lottoListGetRes
                                .map(
                                  (lotto) => Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [
                                            // --- แถว เลขสลาก + เวลา ---
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  lotto.lottoNumber.toString(),
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  lotto.dateStart,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 6),

                                            // --- ราคา ---
                                            Text(
                                              lotto.price.toString(),
                                              style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),

                                            const SizedBox(height: 0),

                                            // --- ปุ่มตรวจหวย ---
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () => saleLotto(
                                                    lotto.lid,
                                                    widget.user,
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors
                                                        .red, // สีพื้นหลังปุ่ม
                                                    foregroundColor: Colors
                                                        .white, // สีตัวหนังสือ
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text("ซื้อหวย"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void randLotto() {
    if (lottoListGetRes.isEmpty) {
      dev.log("ยังไม่มีลอตเตอรี่ให้สุ่ม");
      Get.snackbar("แจ้งเตือน", "ยังไม่มีข้อมูล");
      return;
    }
    final random = Random();
    final randomlid = random.nextInt(lottoListGetRes.length);
    final newNumber = lottoListGetRes[randomlid].lottoNumber.toString();

    setState(() {
      lottoNumber = newNumber;
    });
  }

  findLotto(String lotto) async {
    dev.log(lotto);
    for (var i = 0; i < lottoListGetRes.length; i++) {
      if (lotto == lottoListGetRes[i]) {
        dev.log(lottoListGetRes[i].toString());
      }
    }
  }

  Future<void> loaddatLotto() async {
    try {
      var config = await Configuration.getConfig();
      url = config['apiEndpoint'];
      dev.log("Config: $config");
      var res = await http.get(
        Uri.parse('https://node-project-ho8q.onrender.com/lotto'),
      );
      dev.log(res.body);
      // dev.log(res.body);
      setState(() {
        lottoListGetRes = lottoListGetResFromJson(res.body);
      });
    } catch (e) {
      dev.log(e.toString(), name: "sss");
    }
  }

  saleLotto(int lotto, int uid) async {
    log(lotto);
    int lid = lotto;
    var res = await http.get(
      Uri.parse('https://node-project-ho8q.onrender.com/lotto/${lid}'),
    );
    dev.log(res.body);
    Get.defaultDialog(
      title: "แจ้งเตือน!!",
      middleText: "คุณต้องการซื้อลอตเตอรี่มั้ย",
      textConfirm: "ยืนยัน",
      onConfirm: () async {
        var res = await http.post(
          Uri.parse('https://node-project-ho8q.onrender.com/orders'),

          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"lid": lid, "uid": uid}),
        );

        dev.log(res.body);
      },
      buttonColor: Colors.redAccent,
      cancelTextColor: Colors.black,
      textCancel: "ยกเลิก",
      onCancel: () {
        Get.back();
      },
    );
  }
}

// class ConfigController extends GetxController {
//   late Future<void> loaddata;
//   List<LottoListGetRes> lottoListGetRes = [];
//   var url = "".obs;
//   onInit() {
//     super.onInit();
//     loadConfig();
//   }

//   void loadConfig() async {
//     var config = await Configuration.getConfig();
//     url.value = config['apiEndpoint'];
//   }
// }
