import 'package:flutter/material.dart';
import 'package:lotto_1/pages/homepage.dart';

class Member extends StatefulWidget {
  const Member({super.key});

  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
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
                  child: const Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: const [
                        // User profile icon.
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        SizedBox(width: 16),
                        // User details.
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'น้องโปรเจค',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('รหัสสมาชิก : P123456'),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right),
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
                            const Text(
                              'กระเป๋าตังของฉัน\n100.00 บาท',
                              style: TextStyle(fontSize: 16),
                            ),
                            // Top-up button.
                            ElevatedButton(
                              onPressed: () {
                                // Add your logic for the top-up button here.
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
                                  // Add your logic for the edit button here.
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
                                  // Add your logic for the edit button here.
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Icon button for "หน้าแรก" (Home)
            TextButton(
              onPressed: To_homepage,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.home),
                  Text('หน้าแรก', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            // Icon button for "คำสั่งซื้อ" (Orders)
            TextButton(
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.class_sharp),
                  Text('คำสั่งซื้อ', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            // Icon button for "ตะกร้า" (Cart)
            TextButton(
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.shopping_cart),
                  Text('ตะกร้า', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            // Icon button for "สมาชิก" (Member)
            TextButton(
              onPressed: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.person),
                  Text('สมาชิก', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void To_homepage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }
}
