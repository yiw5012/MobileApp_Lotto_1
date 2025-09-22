import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_1/config/config.dart';
import 'package:lotto_1/pages/homepage.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({super.key});

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  var username_ctl = TextEditingController();
  var email_ctl = TextEditingController();
  var money_ctl = TextEditingController();
  var tal_ctl = TextEditingController();

  var password_ctl = TextEditingController();
  var password2_ctl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 255, 62, 62),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Center(child: Text("Register")),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(30),

              child: Center(
                child: Card(
                  elevation: 4, // เงา
                  color: Colors.white,
                  child: Center(
                    child: Column(
                      children: [
                        buildInputField(
                          username_ctl,
                          'Username',
                          'Enter your username',
                        ),
                        buildInputField(email_ctl, 'Email', 'Enter your email'),
                        buildInputField(
                          tal_ctl,
                          'Phone',
                          'Enter your phone number',
                        ),
                        buildInputField(
                          password_ctl,
                          'Password',
                          'Enter your password',
                          obscure: true,
                        ),
                        buildInputField(
                          password2_ctl,
                          'Confirm Password',
                          'Re-enter your password',
                          obscure: true,
                        ),
                        buildInputField(
                          money_ctl,
                          'Money',
                          'Enter your initial money',
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: 450,
                            height: 50,
                            child: FilledButton(
                              onPressed: () {
                                register();
                              },
                              child: const Text("Register"),
                            ),
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
    //
    //
    // return Scaffold(
    //   body: Container(
    //     color: Colors.redAccent,
    //     child: Center(
    //       child: SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             SizedBox(
    //               child: ClipOval(
    //                 // logo
    //                 child: Image.network(
    //                   "https://scontent.fkkc3-1.fna.fbcdn.net/v/t1.15752-9/527758169_1090055486033709_5459465472049000231_n.png?_nc_cat=109&ccb=1-7&_nc_sid=9f807c&_nc_eui2=AeEhM5WZH65oPIxyDyUCQVVVvvaK68x1Yru-9orrzHViuwIZvcm8F_Sf2xRp66po3QZ3-7bZ2h-3Vn3lXzqYgDSB&_nc_ohc=EeA-KhwYMz8Q7kNvwExRfNT&_nc_oc=AdkKQ7R7E4xDnTS5ExFZ2okYmN6VidOxpYsPQSJZBnIj9NE2okwbBCvJK-s1Pt8rm8GuYwHewfx3uYh2i28iorYX&_nc_zt=23&_nc_ht=scontent.fkkc3-1.fna&oh=03_Q7cD3AE5Bj4bPcRyq-XQEIZWYGjSHppwdbIFp7HzUckfes9jeg&oe=68CA3EB3",
    //                   width: 250,
    //                   height: 250,
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),

    //             Card(
    //               //การ์ด
    //               margin: const EdgeInsets.all(10),
    //               child: SizedBox(
    //                 // boxใหญ่
    //                 child: Column(
    //                   // คอลัม
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.all(10.0),
    //                       child: SizedBox(
    //                         // username
    //                         width: 450,
    //                         child: TextField(
    //                           controller: username_ctl,
    //                           decoration: InputDecoration(
    //                             border: OutlineInputBorder(),
    //                             labelText: 'Username',
    //                             hintText: 'Enter your username',
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.all(10.0),
    //                       child: SizedBox(
    //                         // username
    //                         width: 450,
    //                         child: TextField(
    //                           controller: email_ctl,
    //                           decoration: InputDecoration(
    //                             border: OutlineInputBorder(),
    //                             labelText: 'Email',
    //                             hintText: 'Enter your Email',
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.all(10.0),
    //                       child: SizedBox(
    //                         // username
    //                         width: 450,
    //                         child: TextField(
    //                           controller: tal_ctl,
    //                           decoration: InputDecoration(
    //                             border: OutlineInputBorder(),
    //                             labelText: 'phone',
    //                             hintText: 'Enter your phone',
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.all(10.0),
    //                       child: SizedBox(
    //                         width: 450,
    //                         child: TextField(
    //                           controller: password_ctl,
    //                           // password
    //                           decoration: InputDecoration(
    //                             border: OutlineInputBorder(),
    //                             labelText: 'password',
    //                             hintText: 'Enter your password',
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.all(10.0),
    //                       child: SizedBox(
    //                         width: 450,
    //                         child: TextField(
    //                           controller: password2_ctl,
    //                           // password
    //                           decoration: InputDecoration(
    //                             border: OutlineInputBorder(),
    //                             labelText: 'password confirm ',
    //                             hintText: 'Enter your password confirm',
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.all(10.0),
    //                       child: SizedBox(
    //                         width: 450,
    //                         child: TextField(
    //                           controller: money_ctl,
    //                           decoration: InputDecoration(
    //                             border: OutlineInputBorder(),
    //                             labelText: 'money',
    //                             hintText: 'Enter your first money',
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.all(10.0),
    //                       child: SizedBox(
    //                         // login button
    //                         width: 450,
    //                         height: 50,
    //                         child: FilledButton(
    //                           onPressed: () {
    //                             register();
    //                           },
    //                           child: const Text("Register"),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  Future<void> register() async {
    var username = username_ctl.text.trim();
    var email = email_ctl.text.trim();
    var phone = tal_ctl.text.trim();
    var money = money_ctl.text.trim();
    var password = password_ctl.text;
    var password2 = password2_ctl.text;
    if (username.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        money.isEmpty ||
        password.isEmpty ||
        password2.isEmpty) {
      Get.snackbar(
        'กรอกข้อมูลไม่ครบ',
        'โปรดกรอกข้อมูลให้ครบทุกช่อง',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }
    if (password != password2) {
      Get.snackbar(
        'Password ไม่ตรงกัน',
        'โปรดกรอกรหัสผ่านให้ตรงกัน',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } else {
      var config = await Configuration.getConfig();
      var url = config['apiEndpoint'];
      Get.dialog(
        Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      var res = await http.post(
        Uri.parse("$url/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "email": email,
          "phone": phone,
          "money": money,
          "password": password,
        }),
      );
      log(res.statusCode.toString());
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        Get.snackbar(
          'ลงทะเบียนสำเร็จ',
          'ยินดีต้อนรับ${data['message']}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.to(() => HomePage(uid: data['userId']));
      } else if (res.statusCode == 409) {
        final data = jsonDecode(res.body);
        Get.snackbar(
          'เกิดข้อผิดพลาด',
          data['message'] ?? 'Username ซ้ำ',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'เกิดข้อผิดพลาด',
          'ไม่สามารถลงทะเบียนได้ กรุณาลองใหม่',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }

      // You can now proceed to send data to your backend or navigate
    }
  }

  Widget buildInputField(
    TextEditingController controller,
    String label,
    String hint, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 100, // ความกว้างของ label
            child: Text(
              label,
              style: TextStyle(color: Colors.black), // << เพิ่มตรงนี้
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.black), // << เพิ่มตรงนี้

              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration(labelText: label, hintText: hint),
            ),
          ),
        ],
      ),
    );
  }
}
