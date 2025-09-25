import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lotto_1/config/config.dart';
import 'package:lotto_1/model/request/Lotto_insert_post_res.dart';
import 'package:lotto_1/model/request/wininglotto_add_post_req.dart';
import 'package:lotto_1/model/response/lottolist_get_res.dart';
import 'package:lotto_1/model/response/winning_lotto_res.dart';
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
  late LottoListGetRes lotto;
  var url = '';
  var date_start = TextEditingController();
  var lottonumber = '';
  var date_end = TextEditingController();
  var lotto_price = TextEditingController();
  var copy = TextEditingController();
  final random = Random();
  late Future<void> loadData;
  String? selectdate;
  String? selectmonth;
  bool lotto_have = false;
  int lotto_count = 0;
  // var random_lotto = List<String>;
  // var uid_lotto = List<int>;
  // List<String> = random_lotto = [];
  // Lis
  List<LottoListGetRes> Lottoaddnew = [];
  final Map<String, String> listMonths = {
    "01": "มกราคม",
    "02": "กุมภาพันธ์",
    "03": "มีนาคม",
    "04": "เมษายน",
    "05": "พฤษภาคม",
    "06": "มิถุนายน",
    "07": "กรกฎาคม",
    "08": "สิงหาคม",
    "09": "กันยายน",
    "10": "ตุลาคม",
    "11": "พฤศจิกายน",
    "12": "ธันวาคม",
  };
  final Map<String, String> listdate = {"01": "วันที่ 1", "16": "วันที่ 16"};

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
                    onPressed: () {
                      check_for_random();
                      // CheckForSure(0);
                    },
                    icon: const Icon(
                      Icons.star,
                      size: 24.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    label: const Text(
                      "ออกรางวัล",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      delete_user_lotto();
                    },
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

            Expanded(
              child: ListView.builder(
                itemCount: Lottoaddnew.length,
                itemBuilder: (context, index) {
                  final lotto = Lottoaddnew[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ), // สีพื้นหลังการ์ดแบบหวย
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'สลากกินแบ่งรัฐบาล',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            lotto.lottoNumber.toString().padLeft(6, '0'),
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                              letterSpacing: 4,
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(color: Colors.black),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ราคา: ${lotto.price} บาท',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                'LID: ${lotto.lid}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'วันที่เริ่ม: ${lotto.dateStart.toString().split("T")[0]}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                              Text(
                                'วันสิ้นสุด: ${lotto.dateEnd.toString().split("T")[0]}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void list_of_day_and_month() {}

  void Random_lotto_number() {
    developer.log("Hello world");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: StatefulBuilder(
            builder: (BuildContext context, setStateDialog) {
              return Padding(
                padding: const EdgeInsets.only(),
                child: SingleChildScrollView(
                  child: AlertDialog(
                    title: const Text("สุ่มเลขที่จะเพิ่มใน Lotto"),
                    content: const Text("ใส่ข้อมูลต่างๆ"),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("ประจำงวดวันที่"),
                          Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: Text("ประจำเดือนที่"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: DropdownButton<String>(
                              hint: const Text("เลือกงวด"),
                              value: selectdate,
                              items: listdate.entries.map((entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.key,
                                  child: Text(entry.value),
                                );
                              }).toList(),
                              onChanged: (String? newvalue) {
                                // update inside dialog
                                setStateDialog(() {
                                  selectdate = newvalue;
                                  // developer.log("Date: ${selectdate.toString()}");
                                });

                                // update main state as well
                                setState(() {
                                  date_end.text = newvalue ?? "";
                                  today_date();
                                });

                                // developer.log(selectdate.toString());
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: DropdownButton<String>(
                              hint: const Text("เลือกงวด"),
                              value: selectmonth,
                              items: listMonths.entries.map((entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.key,
                                  child: Text(entry.value),
                                );
                              }).toList(),
                              onChanged: (String? newvalue) {
                                // update inside dialog
                                setStateDialog(() {
                                  selectmonth = newvalue;
                                  // developer.log("month: ${selectmonth.toString()}");
                                });

                                // update main state as well
                                setState(() {
                                  date_end.text = newvalue ?? "";
                                  today_date();
                                });

                                // developer.log(selectdate.toString());
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: copy,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "ทั้งหมดกี่ฉบับ",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: lotto_price,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "ราคาต่อฉบับ",
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilledButton(
                            onPressed: () {
                              CheckForSure(1);
                            },
                            child: const Text("add_lotto"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void CheckForSure(path) {
    // selectdate;
    // selectmonth;
    // developer.log("${selectmonth.toString()}-${selectdate.toString()}");

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
                      developer.log("random_work");
                    } else if (path == 1) {
                      date_config(selectdate, selectmonth);
                      Insert_lotto();
                      developer.log("Today Date: ${date_start.text}");
                      developer.log("Date to add: ${date_end.text}");
                    } else if (path == 2) {
                      delete_all_lotto();
                    } else if (path == 3) {
                      delete_all_users();
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
      final responseJson = jsonDecode(res.body);
      var lid_new = responseJson["lid"];
      getLotto_new(lid_new);
    }
  }

  // Random_lotto_number
  void check_for_random() {
    developer.log("check for random work");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setstateDialog2) {
            return Padding(
              padding: const EdgeInsets.only(),
              child: Center(
                child: SingleChildScrollView(
                  child: AlertDialog(
                    title: const Text("สุ่มออกรางวัล"),
                    content: const Text("เลือกงวดที่ต้องการออกรางวัล"),
                    actions: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("ประจำงวดวันที่"),
                          Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: Text("ประจำเดือนที่"),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: DropdownButton<String>(
                              hint: const Text("เลือกงวด"),
                              value: selectdate,
                              items: listdate.entries.map((entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.key,
                                  child: Text(entry.value),
                                );
                              }).toList(),
                              onChanged: (String? newvalue) {
                                // update inside dialog
                                setstateDialog2(() {
                                  selectdate = newvalue;
                                  // developer.log("Date: ${selectdate.toString()}");
                                });

                                // update main state as well
                                setState(() {
                                  date_end.text = newvalue ?? "";
                                  today_date();
                                });

                                // developer.log(selectdate.toString());
                              },
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: DropdownButton<String>(
                              hint: const Text("เลือกงวด"),
                              value: selectmonth,
                              items: listMonths.entries.map((entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.key,
                                  child: Text(entry.value),
                                );
                              }).toList(),
                              onChanged: (String? newvalue) {
                                // update inside dialog
                                setstateDialog2(() {
                                  selectmonth = newvalue;
                                  // developer.log("month: ${selectmonth.toString()}");
                                });

                                // update main state as well
                                setState(() {
                                  date_end.text = newvalue ?? "";
                                  today_date();
                                });
                                // developer.log(selectdate.toString());
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text("Lotto In Cerren: ${lotto_count}"),
                            ),

                            Text("Lotto Found: ${lotto_have}"),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FilledButton(
                            onPressed: () async {
                              var to_set = await check_lotto_list();
                              bool have = to_set["have"];
                              int count = to_set["count"];

                              setstateDialog2(() {
                                lotto_have = have;
                                lotto_count = count;
                              });
                            },
                            child: Text("Check_Lotto"),
                          ),
                          if (lotto_have && lotto_count >= 5)
                            FilledButton(
                              onPressed: () {
                                developer.log("work");
                                CheckForSure(0);
                              },
                              child: Text("Random_Reward"),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
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
    List<LottoListGetRes> lottolist_after_filter = [];
    developer.log("date End to add: ${date_end.text}");
    for (var lotto_for_filler in lottoList) {
      if (lotto_for_filler.dateEnd.substring(0, 4) ==
          date_end.text.substring(0, 4)) {
        if (lotto_for_filler.dateEnd.substring(5, 7) ==
            date_end.text.substring(5, 7)) {
          if (lotto_for_filler.dateEnd.substring(8, 10) ==
              date_end.text.substring(8, 10)) {
            lottolist_after_filter.add(lotto_for_filler);
          }
        }
      }
    }

    int len = 0;
    List<int> price = [6000000, 200000, 80000, 4000, 2000];
    List<int> wining_list = [];
    for (var lotto in lottolist_after_filter) {
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
      developer.log(lottolist_after_filter[win].lid.toString());
      // developer.log('wining: ${win.toString()}');
      developer.log(lottolist_after_filter[win].lottoNumber.toString());
      developer.log(lottolist_after_filter[win].dateEnd.toString());
      developer.log(price[pri].toString());

      WiningLottoAddPostReq req = WiningLottoAddPostReq(
        lid: lottolist_after_filter[win].lid,
        winningLottoNumber: lottolist_after_filter[win].lottoNumber.toString(),
        rank: pri + 1,
        date: lottolist_after_filter[win].dateEnd,
        prize: price[pri],
      );
      pri++;
      var res = await http.post(
        Uri.parse('$url/lotto/add_winning_lotto'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: winingLottoAddPostReqToJson(req),
      );
      developer.log(res.body);
      developer.log('------------------------------');
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

  void today_date() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    date_start.text = formattedDate;
    // developer.log(date_start.text);
    // setState(() {
    //   print(formattedDate); // Example: 2025-09-19

    //   developer.log("work!!");

    //   developer.log(date_end.text);
    // });
  }

  void date_config(day, month) {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy');
    String formattedDate = formatter.format(now);
    String dateadd =
        "${formattedDate.toString()}-${month.toString()}-${day.toString()}";
    // developer.log(dateadd);
    date_end.text = dateadd;
  }

  Future<Map<String, dynamic>> check_lotto_list() async {
    developer.log("List of lotto wotk");
    date_config(selectdate, selectmonth);
    developer.log(url);
    var res = await http.get(Uri.parse("$url/lotto"));
    // developer.log(res.body);
    // bool lotto_have = false;
    // int lotto_count = 0;
    bool have = false;
    int count = 0;
    List<LottoListGetRes> lottoList = lottoListGetResFromJson(res.body);
    developer.log(date_end.text);
    for (var lotto in lottoList) {
      if (lotto.dateEnd.substring(0, 4) == date_end.text.substring(0, 4)) {
        if (lotto.dateEnd.substring(5, 7) == date_end.text.substring(5, 7)) {
          if (lotto.dateEnd.substring(8, 10) ==
              date_end.text.substring(8, 10)) {
            developer.log(lotto.dateEnd);
            developer.log(lotto.dateEnd.substring(0, 4));
            developer.log(lotto.dateEnd.substring(5, 7));
            developer.log(lotto.dateEnd.substring(8, 10));
            have = true;
            count++;
          }
        }
      }
      continue;
    }
    if (have) {
      // setState(() {
      //   lotto_count = count;
      //   lotto_have = have;
      // });
      developer.log("lotto have");
      developer.log("Lotto_count: ${lotto_count}");
    } else {
      // setState(() {
      //   lotto_count = 0;
      //   lotto_have = false;
      // });
      have = false;
      count = 0;
      developer.log("lotto not have");
    }
    return {"have": have, "count": count};
    // developer.log(lottoList.toString());
  }

  void delete_user_lotto() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: StatefulBuilder(
            builder: (BuildContext context, setstateDialog3) {
              return Padding(
                padding: const EdgeInsets.only(),
                child: Center(
                  child: SingleChildScrollView(
                    child: AlertDialog(
                      title: const Text("ลบข้อมูลในฐานข้อมูล"),
                      content: const Text(
                        "เลือกข้อมูลที่จะลบตามฟังก์ชันดังนี้",
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FilledButton(
                              onPressed: () {
                                CheckForSure(2);
                              },
                              child: const Text("Delete Lottos"),
                            ),
                            FilledButton(
                              onPressed: () {
                                CheckForSure(3);
                              },
                              child: const Text("Delete Users"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void delete_all_lotto() async {
    developer.log("delete all lotto work");
    var res = await http.delete(Uri.parse("$url/lotto/delete_lotto"));
    developer.log(res.body);
  }

  void delete_all_users() async {
    developer.log("delete users work");
    var res = await http.delete(Uri.parse("$url/user/delete_users"));
    developer.log(res.body);
  }

  Future<void> getLotto_new(lid_new) async {
    var res = await http.get(Uri.parse("$url/lotto/$lid_new"));

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      // ✅ กรณี server ส่งมาเป็น List
      if (data is List && data.isNotEmpty) {
        final lotto = LottoListGetRes.fromJson(data[0]); // ใช้ item แรก
        setState(() {
          if (!Lottoaddnew.any((e) => e.lid == lotto.lid)) {
            Lottoaddnew.add(lotto);
          } // หรือเก็บใน list เพื่อใช้ .map
        });
      }
    } else {
      print("ไม่พบข้อมูลล็อตโต้ lid = $lid_new");
    }
  }
}
