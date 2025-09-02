import 'package:flutter/material.dart';

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
    );
  }
}
