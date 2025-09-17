import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_1/config/config.dart';
import 'package:lotto_1/model/response/Lotto_get_respon.dart';
import 'package:lotto_1/model/response/Order_get_respon.dart';

class Cartpage extends StatefulWidget {
  final int uid;
  const Cartpage({super.key, required this.uid});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
                                    // ตรวจหวย
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
                                    payOrder(
                                      widget.uid,
                                      order.oid,
                                      order.price,
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

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("ชำระเงิน"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              final res = await http.post(
                Uri.parse('$url/order/pay'),
                headers: {"Content-Type": "application/json"},
                body: jsonEncode({"uid": uid, "oid": oid, "price": price}),
              );

              if (res.statusCode == 200) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('ชำระเงินสำเร็จ')));

                // โหลดข้อมูลใหม่
                setState(() {
                  loadData = loadDataAsync();
                });
                Navigator.of(context).pop(); // ✅ ปิด Dialog ก่อนส่งคำขอ
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('ชำระเงินไม่สำเร็จ: ${res.body}')),
                );
              }
            },
            child: Text("ยืนยัน"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // ❌ ยกเลิก => ปิด Dialog
            },
            child: Text("ยกเลิก"),
          ),
        ],
      ),
    );
  }
}
