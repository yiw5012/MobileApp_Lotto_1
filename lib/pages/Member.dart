import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lotto_1/pages/homepage.dart';

class Member extends StatefulWidget {
  const Member({super.key});

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  String credit_left = "200";
  String username = " YEW";
  String userId = "111213";
  var creditctl = TextEditingController();
  var userctl = TextEditingController();
  var fullnamectl = TextEditingController();
  var Emailctl = TextEditingController();
  var house_numberctl = TextEditingController();
  var districtctl = TextEditingController();
  var district_bigctl = TextEditingController();
  var cityctl = TextEditingController();
  var postal_codectl = TextEditingController();

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
                              Text('รหัสสมาชิก : $userId'),
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
                              'กระเป๋าตังของฉัน\n$credit_left บาท',
                              style: const TextStyle(fontSize: 16),
                            ),
                            // Top-up button.
                            ElevatedButton(
                              onPressed: () {
                                // Add your logic for the top-up button here.
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("เติมเงิน"),
                                      content: const Text(
                                        "ใส่จำนวนเงินที่ต้องการเติม",
                                      ),
                                      actions: [
                                        TextField(
                                          controller: creditctl,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(width: 1),
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
                                              top_up(context);
                                              creditctl.clear();
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
                            const Text("ข้อมูลของคุณ"),
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
                                            controller: userctl,
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
                                                child: Text("ชื่อสกุล"),
                                              ),
                                            ],
                                          ),
                                          TextField(
                                            controller: fullnamectl,
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
                                            controller: Emailctl,
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
                                                edit_user_info(context);
                                                userctl.clear();
                                                fullnamectl.clear();
                                                Emailctl.clear();
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("ที่อยู่ของคุณ"),
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
                                        title: const Text("แก้ไขที่อยู่ของคุณ"),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                ),
                                                child: Text("บ้านเลขที่"),
                                              ),
                                              TextField(
                                                controller: house_numberctl,
                                                decoration:
                                                    const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                ),
                                                child: Text("ตำบล"),
                                              ),
                                              TextField(
                                                controller: districtctl,
                                                decoration:
                                                    const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                ),
                                                child: Text("อำเภอ"),
                                              ),
                                              TextField(
                                                controller: district_bigctl,
                                                decoration:
                                                    const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                ),
                                                child: Text("จังหวัด"),
                                              ),
                                              TextField(
                                                controller: cityctl,
                                                decoration:
                                                    const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                  top: 8,
                                                  bottom: 8,
                                                ),
                                                child: Text("รหัสไปรษณีย์"),
                                              ),
                                              TextField(
                                                controller: postal_codectl,
                                                decoration:
                                                    const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text("OK"),
                                            onPressed: () {
                                              edit_user_address(context);
                                              house_numberctl.clear();
                                              districtctl.clear();
                                              district_bigctl.clear();
                                              cityctl.clear();
                                              postal_codectl.clear();
                                            },
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
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Contact staff button.
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: const Text('ติดต่อเจ้าหน้าที่'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Add your logic for contacting staff here.
                    },
                  ),
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
        ),
      ),

      // Bottom navigation bar.
    );
  }

  void To_homepage() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => HomePage()),
    // );
  }

  void top_up(BuildContext context) {
    int? topup = int.tryParse(creditctl.text);
    if (topup != null && topup > 0) {
      setState(() {
        int currentCredit = int.parse(credit_left);
        currentCredit += topup;
        credit_left = currentCredit.toString();
      });
    }
    Navigator.of(context).pop();
  }

  void edit_user_info(BuildContext context) {
    var testname = userctl.text;
    var testfullname = fullnamectl.text;
    var testemail = Emailctl.text;
    log(testname);
    log(testfullname);
    log(testemail);
    setState(() {});
    Navigator.of(context).pop();
  }

  void edit_user_address(BuildContext context) {
    var testhouse = house_numberctl.text;
    var test_small_d = districtctl.text;
    var test_big_d = district_bigctl.text;
    var test_city = cityctl.text;
    var testaddress = postal_codectl.text;
    log(testhouse);
    log(test_small_d);
    log(test_big_d);
    log(test_city);
    log(testaddress);
    setState(() {});

    Navigator.of(context).pop();
  }
}
