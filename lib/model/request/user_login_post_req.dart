// To parse this JSON data, do
//
//     final userLoginPostReq = userLoginPostReqFromJson(jsonString);

import 'dart:convert';

UserLoginPostReq userLoginPostReqFromJson(String str) => UserLoginPostReq.fromJson(json.decode(str));

String userLoginPostReqToJson(UserLoginPostReq data) => json.encode(data.toJson());

class UserLoginPostReq {
    String username;
    String password;

    UserLoginPostReq({
        required this.username,
        required this.password,
    });

    factory UserLoginPostReq.fromJson(Map<String, dynamic> json) => UserLoginPostReq(
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
    };
}
