import 'dart:math';

import 'package:flutter/material.dart';
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
                    child: Image.network(
                      "https://scontent.fkkc3-1.fna.fbcdn.net/v/t1.15752-9/527758169_1090055486033709_5459465472049000231_n.png?_nc_cat=109&ccb=1-7&_nc_sid=9f807c&_nc_eui2=AeEhM5WZH65oPIxyDyUCQVVVvvaK68x1Yru-9orrzHViuwIZvcm8F_Sf2xRp66po3QZ3-7bZ2h-3Vn3lXzqYgDSB&_nc_ohc=EeA-KhwYMz8Q7kNvwExRfNT&_nc_oc=AdkKQ7R7E4xDnTS5ExFZ2okYmN6VidOxpYsPQSJZBnIj9NE2okwbBCvJK-s1Pt8rm8GuYwHewfx3uYh2i28iorYX&_nc_zt=23&_nc_ht=scontent.fkkc3-1.fna&oh=03_Q7cD3AE5Bj4bPcRyq-XQEIZWYGjSHppwdbIFp7HzUckfes9jeg&oe=68CA3EB3",
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

            if (userlogin.loginMatch != null && userlogin.loginMatch) {
              if (userlogin.roleId == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Adminpage()),
                );
              } else if (userlogin.roleId == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const HomePage()),
              // );
            }
          } else {
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
