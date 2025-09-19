import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lotto_1/config/config.dart';
import 'package:lotto_1/model/request/Lotto_insert_post_res.dart';
import 'package:lotto_1/model/request/wininglotto_add_post_req.dart';
import 'package:lotto_1/model/response/lottolist_get_res.dart';
import 'package:lotto_1/pages/Member.dart';
import 'package:lotto_1/pages/adminProfile.dart';
import 'package:lotto_1/pages/cart.dart';
import 'package:lotto_1/pages/homepage.dart';
import 'package:lotto_1/pages/sell.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class Adminpage extends StatefulWidget {
  final int uid;
  final String? username;
  final String? email;
  final String? tel;
  final int? roleId;
  const Adminpage({
    super.key,
    required this.uid,
    this.username,
    this.email,
    this.tel,
    this.roleId,
  });

  @override
  State<Adminpage> createState() => _AdminpageState();
}

class _AdminpageState extends State<Adminpage> {
  int _selectedIndex = 0; // เก็บ index ของ nav bar
  late List<Widget> _pages;
  List<DateTime?> _selectedDates = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      AdminContent(uid: widget.uid), // หน้าแรก
      const Sell(),
      Adminprofile(
        uid: widget.uid,
        name: widget.username,
        email: widget.email,
        tel: widget.tel,
        roleId: widget.roleId,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "สมาชิก"),
        ],
      ),
    );
  }
}

class AdminContent extends StatefulWidget {
  final int uid;
  const AdminContent({super.key, required this.uid});
  @override
  State<AdminContent> createState() => _AdminContentState();
}

class _AdminContentState extends State<AdminContent> {
  var url = '';
  var date_start = TextEditingController();
  var lottonumber = '';
  var date_end = TextEditingController();
  var lotto_price = TextEditingController();
  var copy = TextEditingController();
  final random = Random();
  late Future<void> loadData;
  // var random_lotto = List<String>;
  // var uid_lotto = List<int>;
  // List<String> = random_lotto = [];
  // Lis

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
    });
    // loadData = getlotto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(title: const Text("Admin Page"), centerTitle: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "สุ่มออก",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            const Text(
              "รางวัลลอตเตอรี่",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: const Text(
                "งวดวันที่ 16 สิงหาคม 2568",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      side: BorderSide(
                        width: 2.0,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

                      // สีพื้นหลังปุ่ม
                    ),
                    onPressed: (Random_lotto_number),
                    icon: const Icon(
                      Icons.star,
                      size: 24.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    label: const Text(
                      "สุ่มรางวัล",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        width: 2.0,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: const Color.fromARGB(255, 10, 2, 159),
                      // สีพื้นหลังปุ่ม
                    ),
                    child: Text(
                      "รีเช็ตระบบ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Container(
                    width: 280,
                    height: 350,
                    child: Column(
                      children: const [
                        Text(
                          "รางวัลที่ 1",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "123456",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void Random_lotto_number() {
    developer.log("Hello world");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 130),
          child: SingleChildScrollView(
            child: AlertDialog(
              title: const Text("สุ่มเลขที่จะเพิ่มใน Lotto"),
              content: const Text("ใส่ข้อมูลต่างๆ"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: date_start,
                    decoration: InputDecoration(
                      labelText: "ประจำงวดวันที่ (YYYY-MM-DD)",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: date_end,
                    decoration: InputDecoration(
                      labelText: "สิ้นสุดวันที่ (YYYY-MM-DD)",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: copy,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "ทั้งหมดกี่ฉบับ"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TextField(
                    controller: lotto_price,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "ราคาต่อฉบับ"),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    TextButton(
                      onPressed: () {
                        CheckForSure(0);
                      },
                      child: Text("Random_reward"),
                    ),
                    FilledButton(
                      onPressed: () {
                        CheckForSure(1);
                      },
                      child: Text("add_lotto"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void CheckForSure(path) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("คูณแน่ใจหรือยังที่จะทำรายการต่อไปนี้"),
          content: Text("ยืนยันการทำรายการ"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text("ยกเลิก"),
                ),
                FilledButton(
                  onPressed: () {
                    if (path == 0) {
                      Random_reward();
                    } else {
                      Insert_lotto();
                    }
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text("ยืนยัน"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void Random_reward() {
    developer.log("Random_reward");
    getlotto();
  }

  void Insert_lotto() {
    developer.log("Insert_lotto");
    developer.log(copy.text);
    developer.log(lotto_price.text);
    var startdate = date_start.text;
    var enddate = date_end.text;
    var admin_uid = widget.uid;

    int? numberOfCopies = int.tryParse(copy.text);
    int? pricelotto = int.tryParse(lotto_price.text);

    if (numberOfCopies != null &&
        pricelotto != null &&
        startdate.isNotEmpty &&
        enddate.isNotEmpty &&
        pricelotto != null) {
      developer.log('$url');
      List<String> lotto_num_list = Random_number(numberOfCopies);
      lotto_to_database(
        admin_uid,
        lotto_num_list,
        startdate,
        enddate,
        pricelotto,
      );
      // developer.log('Generated Lotto Numbers: $lotto_num_list');
    } else {
      // Handle the case where the input is not a valid number
      developer.log('Invalid number of copies entered.');
      // You might want to show a SnackBar or an alert dialog to the user here.
    }
  }

  Future<void> lotto_to_database(
    int uid,
    List<String> lotto_list,
    String DateStart,
    String DateEnd,
    int lottoprice,
  ) async {
    for (int index = 0; index < lotto_list.length; index++) {
      LottoInsertPostreq req = LottoInsertPostreq(
        uid: uid,
        lottoNumber: lotto_list[index],
        dateStart: DateStart,
        dateEnd: DateEnd,
        price: lottoprice,
        saleStatus: 1,
        lottoResultStatus: 1,
      );

      var res = await http.post(
        Uri.parse('https://node-project-ho8q.onrender.com/lotto/add_lotto'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: lottoInsertPostreqToJson(req),
      );

      developer.log("Inserted ${lotto_list[index]} → ${res.body}");
    }
  }

  Future<void> getlotto() async {
    var res = await http.get(
      Uri.parse("https://node-project-ho8q.onrender.com/lotto"),
    );
    // developer.log(res.body);
    List<LottoListGetRes> lottoList = lottoListGetResFromJson(res.body);
    // developer.log(lotto_list.lottoNumber);
    // for (int i = 0; i < lottoList.length; i++) {
    //     developer.log("Lotto number: ${lottoList[i].lottoNumber}");
    //     developer.log("Price: ${lottoList[i].price}");
    // developer.log(lottoList.length.toString());
    //   }
    int len = 0;
    List<int> price = [6000000, 200000, 80000, 4000, 2000];
    List<int> wining_list = [];
    for (var lotto in lottoList) {
      // developer.log(lotto.lottoNumber.bitLength.toString());
      // if (lotto.lottoNumber.toString().length == 6) {
      // developer.log('${lotto.lottoNumber}, ${lotto.price}, ${lotto.lid}');
      // }
      len++;
    }
    // developer.log(len.toString());

    for (int i = 0; i < 5; i++) {
      wining_list.add(random.nextInt(len));
    }
    int pri = 0;
    for (var win in wining_list) {
      developer.log(lottoList[win].lid.toString());
      // developer.log('wining: ${win.toString()}');
      developer.log(lottoList[win].lottoNumber.toString());
      developer.log(lottoList[win].dateEnd.toString());
      developer.log(price[pri].toString());
      pri++;
      developer.log('------------------------------');
      WiningLottoAddPostReq req = WiningLottoAddPostReq(
        lid: lottoList[win].lid,
        winningLottoNumber: lottoList[win].lottoNumber.toString(),
        rank: pri + 1,
        date: lottoList[win].dateEnd,
        prize: price[pri],
      );
      var res = await http.post(
        Uri.parse('$url/lotto/add_winning_lotto'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: winingLottoAddPostReqToJson(req),
      );
      developer.log(res.body);
    }
  }

  List<String> Random_number(int number) {
    List<String> lotto_num_list = [];
    String lotto_num = '';
    for (int i = 0; i < number; i = i + 1) {
      for (int j = 0; j < 6; j = j + 1) {
        var num = random.nextInt(10);
        lotto_num += num.toString();
      }
      lotto_num_list.add(lotto_num);
      lotto_num = '';
    }
    developer.log('lotto_num_list as String: $lotto_num_list');
    return lotto_num_list;
  }
}
