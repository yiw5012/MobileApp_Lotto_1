import 'package:flutter/material.dart';
import 'package:lotto_1/peges/cart.dart';
import 'package:lotto_1/peges/homepage.dart';
import 'package:lotto_1/peges/sell.dart';

class Member extends StatefulWidget {
  const Member({super.key});

  @override
  State<Member> createState() => MemberState();
}

class MemberState extends State<Member> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Memberpage")),
      body: Container(color: Colors.redAccent),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Icon button for "หน้าแรก" (Home)
            TextButton(
              onPressed: home,
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
              onPressed: sell,
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
              onPressed: cart,
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
              onPressed: member,
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

  void home() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void member() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Member()));
  }

  void sell() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Sell()),
    );
  }

  void cart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Cartpage()),
    );
  }
}
