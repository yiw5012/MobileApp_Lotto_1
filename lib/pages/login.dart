import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lotto_1/model/response/user_login_post_res.dart';
import 'package:lotto_1/pages/adminpage.dart';
import 'package:lotto_1/pages/cart.dart';
import 'package:lotto_1/pages/homepage.dart';
import 'package:lotto_1/pages/register.dart';
import "package:http/http.dart" as http;
import "dart:convert";
import 'package:lotto_1/config/config.dart';

import 'dart:developer' as developer;

class LoginPeges extends StatefulWidget {
  const LoginPeges({super.key});

  @override
  State<LoginPeges> createState() => _LoginPegesState();
}

class _LoginPegesState extends State<LoginPeges> {
  var username_ctl = TextEditingController();
  var password_ctl = TextEditingController();
  String url = '';

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
    });
  }

  String button = 'Sign in';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  child: ClipOval(
                    // logo
                    child: Image.asset(
                      "assets/logo.png",
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Card(
                  //การ์ด
                  margin: const EdgeInsets.all(20),
                  child: SizedBox(
                    // boxใหญ่
                    width: 500,
                    height: 350,
                    child: Column(
                      // คอล
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            // username
                            width: 450,
                            child: TextField(
                              controller: username_ctl,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                                hintText: 'Enter your username',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: 450,
                            child: TextField(
                              // password
                              controller: password_ctl,
                              obscureText: true,

                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'password',
                                hintText: 'Enter your password',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            // login button
                            width: 450,
                            height: 50,
                            child: FilledButton(
                              onPressed: login,
                              child: Text("$button"),
                            ),
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                child: TextButton(
                                  // forgot password
                                  onPressed: () {},
                                  child: const Text("Forgot Password?"),
                                ),
                              ),
                              SizedBox(
                                child: TextButton(
                                  // register
                                  onPressed: register,
                                  child: const Text("Register"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    var username = username_ctl.text;
    var password = password_ctl.text;
    var data = {'user_name': username, 'password': password};
    http
        .post(
          Uri.parse('$url/login'),
          headers: {"Content-Type": "application/json; charset=utf-8"},
          body: jsonEncode(data),
        )
        .then((value) {
          if (value.statusCode == 200) {
            developer.log(value.body);
            UserLoginPostRes userlogin = userLoginPostResFromJson(value.body);
            // developer.log(value.body);

            developer.log(userlogin.username);
            developer.log(userlogin.email);
            // developer.log(userlogin.)

            if (userlogin.loginMatch != null && userlogin.loginMatch) {
              if (userlogin.roleId == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Adminpage(
                      uid: userlogin.uid,
                      username: userlogin.username,
                      email: userlogin.email,
                      tel: userlogin.tel,
                      roleId: userlogin.roleId,
                    ),
                  ),
                );
              } else if (userlogin.roleId == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(uid: userlogin.uid),
                  ),
                );
              }
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const HomePage()),
              // );
            }
          } else {
            Get.snackbar(
              "รหัสผ่านไม่ถูกต้อง",
              "กรุณากรอกรหัสผ่านใหม่",
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
            );
            developer.log('password not valid');
          }
        })
        .catchError((error) {
          developer.log("HTTP Error: ${error.toString()}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("เกิดข้อผิดพลาด: ${error.toString()}")),
          );
        });
  }
  // Future<void> login() async {
  //   var username = username_ctl.text;
  //   var password = password_ctl.text;
  //   // final res = await http.get(Uri.parse('http://10.0.2.2:5000'));
  //   // final decode = json.decode(res.body) as Map<String, dynamic>;
  //   final url = Uri.parse('http://10.0.2.2:5000/users');

  //   final res = await http.post(
  //     url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     // 3. Create a JSON body with the username and password
  //     body: jsonEncode(<String, String>{
  //       'username': username,
  //       'password': password,
  //     }),
  //   );
  //   if (res.statusCode == 200) {
  //     // Backend successfully processed the login
  //     final decoded = json.decode(res.body) as Map<String, dynamic>;
  //     if (decoded is Map<String, dynamic>) {
  //       // If the backend returns a single object
  //       print('Login successful: ${decoded['message']}');
  //       // ... your login success logic
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const HomePage()),
  //       );
  //     } else if (decoded is List<dynamic>) {
  //       // If the backend returns a list of objects
  //       print('Received a list from the server.');
  //       // You may need to handle the list of data
  //       // For example, if you want to get the first item's message:
  //       if (decoded.isNotEmpty && decoded[0] is Map<String, dynamic>) {
  //         print('First item message: ${decoded[0]['message']}');
  //       }
  //     } else {
  //       // Handle unexpected response types
  //       print('Unexpected response type from the server.');
  //     }
  //   }
  //   // setState(() {
  //   //   button = decode['greetings'];
  //   // });
  // }

  void register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPages()),
    );
  }
}
