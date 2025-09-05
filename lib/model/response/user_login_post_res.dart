// To parse this JSON data, do
//
//     final userLoginPostRes = userLoginPostResFromJson(jsonString);

import 'dart:convert';

UserLoginPostRes userLoginPostResFromJson(String str) {
  final decodedData = json.decode(str);
  // Check if the decoded data is a list and get the first element
  if (decodedData is List && decodedData.isNotEmpty) {
    return UserLoginPostRes.fromJson(decodedData[0]);
  }
  // If not a list or empty, handle the error gracefully
  throw Exception("Invalid JSON format: Expected a non-empty list.");
}

String userLoginPostResToJson(UserLoginPostRes data) => json.encode(data.toJson());

class UserLoginPostRes {
    String email;
    bool loginMach;
    int money;
    int roleId;
    String tel;
    int uid;
    String username;

    UserLoginPostRes({
        required this.email,
        required this.loginMach,
        required this.money,
        required this.roleId,
        required this.tel,
        required this.uid,
        required this.username,
    });

    factory UserLoginPostRes.fromJson(Map<String, dynamic> json) => UserLoginPostRes(
        email: json["email"],
        loginMach: json["login_mach"],
        money: json["money"],
        roleId: json["role_id"],
        tel: json["tel"],
        uid: json["uid"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "login_mach": loginMach,
        "money": money,
        "role_id": roleId,
        "tel": tel,
        "uid": uid,
        "username": username,
    };
}
