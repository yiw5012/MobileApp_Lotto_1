// To parse this JSON data, do
//
//     final checkLotto = checkLottoFromJson(jsonString);

import 'dart:convert';

CheckLotto checkLottoFromJson(String str) =>
    CheckLotto.fromJson(json.decode(str));

String checkLottoToJson(CheckLotto data) => json.encode(data.toJson());

class CheckLotto {
  String message;
  Data data;

  CheckLotto({required this.message, required this.data});

  factory CheckLotto.fromJson(Map<String, dynamic> json) =>
      CheckLotto(message: json["message"], data: Data.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"message": message, "data": data.toJson()};
}

class Data {
  int old;
  int prize;

  Data({required this.old, required this.prize});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(old: json["old"], prize: json["prize"]);

  Map<String, dynamic> toJson() => {"old": old, "prize": prize};
}
