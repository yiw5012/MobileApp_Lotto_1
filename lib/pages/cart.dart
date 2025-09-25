import 'dart:convert';
import 'dart:developer';
import 'dart:math' as dev;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_1/config/config.dart';
import 'package:lotto_1/model/response/Order_get_respon.dart';
import 'package:lotto_1/model/response/checkLotto_res.dart';
import 'package:lotto_1/pages/Member.dart';
import 'package:lotto_1/pages/homepage.dart';
import 'package:lotto_1/pages/sell.dart';

class Cartpage extends StatefulWidget {
  final int uid;
  final int initialIndex;
  const Cartpage({Key? key, required this.uid, this.initialIndex = 0})
    : super(key: key);

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
  }

  void changeTab(int index) {
    _tabController.animateTo(index);
  }

  @override
  void dispose() {
    _tabController.dispose(); // cleanup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ระบบลอตเตอรี่'),
        backgroundColor: Colors.red,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.receipt_long), text: 'รายการซื้อ'),
            Tab(icon: Icon(Icons.payment), text: 'ตรวจหวย'),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.offAll(() => HomePage(uid: widget.uid)),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PayMentPage(uid: widget.uid),
          PayMentOrder(uid: widget.uid),
        ],
      ),
    );
  }
}

class _CartpageStatebody extends State<Cartpage>
    with SingleTickerProviderStateMixin {
  String lottoNumber = ""; // ค่าเริ่มต้น
  int _selectedIndex = 0; // เก็บ index ของ nav bar
  late List<Widget> _pages;

  String url = '';

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

class PayMentOrder extends StatefulWidget {
  final int uid;
  const PayMentOrder({super.key, required this.uid});

  @override
  _PayMentOrderState createState() => _PayMentOrderState();
}

class _PayMentOrderState extends State<PayMentOrder> {
  late Future<void> loadData;
  String url = '';
  List<OrderGetResponse> orderGetRespon = [];
  @override
  void initState() {
    super.initState();
    loadData = loadDataAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: loadData,
              builder: (context, snapshot) {
                // if (snapshot.connectionState != ConnectionState.done) {
                //   return const Center(child: CircularProgressIndicator());
                // }

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
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(order.lottoNumber.toString()),
                                Text(
                                  order.date.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "${order.price} บาท",
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: 'ตรวจหวย',
                                      content: const Text(
                                        "คุรต้องการตรวจหวยมั้ย",
                                      ),
                                      barrierDismissible: true,
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text("ปิด"),
                                        ),
                                        FilledButton(
                                          onPressed: () async {
                                            Get.back(); // ปิด dialog confirm

                                            // แสดง loading
                                            // Get.dialog(
                                            //   const Center(
                                            //     child:
                                            //         CircularProgressIndicator(),
                                            //   ),
                                            //   barrierDismissible: false,
                                            // );

                                            // รอผลตรวจหวย
                                            await check_lotto(
                                              widget.uid,
                                              order.lottoNumber,
                                              order.lid,
                                              order.oid,
                                            );

                                            // ปิด loading
                                            // if (Get.isDialogOpen ?? false) {
                                            //   Get.back();
                                            // }

                                            // โหลดข้อมูลใหม่เพื่อ refresh หน้า
                                          },
                                          child: Text("ตรวจจ้ะ"),
                                        ),
                                      ],
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
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

    var res = await http.get(Uri.parse('$url/order/${widget.uid}/paid'));
    log(res.body);
    setState(() {
      orderGetRespon = orderGetResponseFromMap(res.body);
    });
  }

  Future<void> check_lotto(int uid, int lotto, int lid, int oid) async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    final res = await http.post(
      Uri.parse('$url/order/check_lotto'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "uid": uid,
        "lotto_number": lotto,
        "lid": lid,
        "oid": oid,
      }),
    );

    log(res.statusCode.toString());
    log(res.body);

    final responseJson = jsonDecode(res.body);

    if (res.statusCode != 200) {
      Get.defaultDialog(
        title: 'เกิดข้อผิดพลาด',
        content: Text("ไม่สามารถเชื่อมต่อกับเซิร์ฟเวอร์ได้"),
        actions: [TextButton(onPressed: () => Get.back(), child: Text("ปิด"))],
      );
      return;
    }

    final message = responseJson["message"].toString();
    final data = responseJson["data"];

    // ✅ ถูกรางวัล
    if (message.contains("ถูกรางวัล") && data != null) {
      var oid = data["oid"];
      int prize = data["prize"];
      var rank = data["rank"];

      Get.defaultDialog(
        title: 'คุณถูกรางวัลที่ $rank',
        content: Text("คุณถูกรางวัล $prize บาท"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              Get.to(() => Cartpage(uid: uid));
            },
            child: Text("ปิด"),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.dialog(
                Center(child: CircularProgressIndicator()),
                barrierDismissible: false,
              );

              final updateRes = await http.post(
                Uri.parse('$url/order/updateMoney'),
                headers: {"Content-Type": "application/json"},
                body: jsonEncode({"uid": uid, "oid": oid, "prize": prize}),
              );

              Get.back(); // ปิด loading

              if (updateRes.statusCode == 200) {
                Get.snackbar(
                  "สำเร็จ",
                  "ขึ้นเงินสำเร็จแล้ว",
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
                Get.off(() => Member(uid: uid));
              } else {
                Get.snackbar("ล้มเหลว", "ไม่สามารถขึ้นเงินได้");
              }
            },
            child: Text("ขึ้นเงิน"),
          ),
        ],
      );
      log(responseJson["message"]);
    } else {
      Get.defaultDialog(
        title: 'คุณไม่ถูกรางวัล',
        content: Text("คุณไม่ถูกรางวัล แย่จัง!!"),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // ✅ ปิด dialog ก่อน
              // Get.to(() {
              //   final cartState = Get.context
              //       ?.findAncestorStateOfType<_CartpageState>();
              //   cartState?.changeTab(1);
              // });
            },
            child: Text("ปิด"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(); // ✅ ปิด dialog ก่อน
              Get.to(() => HomePage(uid: uid));
            },
            child: Text("ชื้อหวยอีกก!!"),
          ),
        ],
      );
      log(responseJson["message"]);
    }
  }
}

class PayMentPage extends StatefulWidget {
  final int uid;
  const PayMentPage({super.key, required this.uid});

  @override
  State<PayMentPage> createState() => _PayMentPageState();
}

class _PayMentPageState extends State<PayMentPage> {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(),
          ),
          const SizedBox(height: 10),
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
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(order.lottoNumber.toString()),
                                Text(
                                  order.date.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "${order.price} บาท",
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: 'ชำระเงิน',
                                      content: Text("กรุณาชำระเงินด้วย"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text("ปิด"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Get.back();

                                            payOrder(
                                              widget.uid,
                                              order.oid,
                                              order.price,
                                            );
                                          },
                                          child: Text("ทำการชำระเงิน"),
                                        ),
                                      ],
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text("ชำระเงิน"),
                                ),
                              ],
                            ),
                          ],
                        ),
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

    var res = await http.get(Uri.parse('$url/order/${widget.uid}/pending'));
    log(res.body);

    setState(() {
      orderGetRespon = orderGetResponseFromMap(res.body);
      log(orderGetRespon.toString());
    });
  }

  void payOrder(int uid, int oid, int price) async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];
    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
    final res = await http.post(
      Uri.parse('$url/order/pay'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"uid": uid, "oid": oid, "price": price}),
    );
    Get.back();
    if (res.statusCode == 200) {
      final snackBar = SnackBar(
        content: Text('ชำระเงินสำเร็จ'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      );

      final controller = ScaffoldMessenger.of(context).showSnackBar(snackBar);
      controller.closed.then((_) {
        Get.off(() => Cartpage(uid: uid, initialIndex: 1));

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final cartstate = Get.context
              ?.findAncestorStateOfType<_CartpageState>();
          cartstate?.changeTab(0);
        });
      });
    } else {
      Get.snackbar(
        "แจ้งเตือน",
        "เงินไม่เพียงพอ",
        icon: Icon(Icons.notification_important),
      );
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(SnackBar(content: Text('ชำระเงินไม่สำเร็จ: ${res.body}')));
    }
  }
}
