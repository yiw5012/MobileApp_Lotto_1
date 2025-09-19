// To parse this JSON data, do
//
//     final lottoListGetRes = lottoListGetResFromJson(jsonString);

import 'dart:convert';

List<LottoListGetRes> lottoListGetResFromJson(String str) =>
    List<LottoListGetRes>.from(
      json.decode(str).map((x) => LottoListGetRes.fromJson(x)),
    );

String lottoListGetResToJson(List<LottoListGetRes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LottoListGetRes {
  int lid;
  int uid;
  int lottoNumber;
  String dateStart;
  String dateEnd;
  int price;
  int saleStatus;
  int lottoResultStatus;

  LottoListGetRes({
    required this.lid,
    required this.uid,
    required this.lottoNumber,
    required this.dateStart,
    required this.dateEnd,
    required this.price,
    required this.saleStatus,
    required this.lottoResultStatus,
  });

  factory LottoListGetRes.fromJson(Map<String, dynamic> json) =>
      LottoListGetRes(
        lid: json["lid"],
        uid: json["uid"],
        lottoNumber: json["lotto_number"],
        dateStart: json["date_start"],
        dateEnd: json["date_end"],
        price: json["price"],
        saleStatus: json["sale_status"],
        lottoResultStatus: json["lotto_result_status"],
      );

  Map<String, dynamic> toJson() => {
    "lid": lid,
    "uid": uid,
    "lotto_number": lottoNumber,
    "date_start": dateStart,
    "date_end": dateEnd,
    "price": price,
    "sale_status": saleStatus,
    "lotto_result_status": lottoResultStatus,
  };
}
