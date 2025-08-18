import 'package:flutter/material.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({super.key});

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
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
                      // คอลัม
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            // username
                            width: 450,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                                hintText: 'Enter your username',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 450,
                          child: TextField(
                            // password
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'password',
                              hintText: 'Enter your password',
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
                              onPressed: () {},
                              child: const Text("Register"),
                            ),
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
}
