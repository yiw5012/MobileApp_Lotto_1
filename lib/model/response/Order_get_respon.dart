// To parse this JSON data, do
//
//     final orderGetResponse = orderGetResponseFromMap(jsonString);

import 'dart:convert';

List<OrderGetResponse> orderGetResponseFromMap(String str) =>
    List<OrderGetResponse>.from(
      json.decode(str).map((x) => OrderGetResponse.fromMap(x)),
    );

String orderGetResponseToMap(List<OrderGetResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class OrderGetResponse {
  int oid;
  int lid;
  int uid;
  String date;
  String paymentStatus;
  int lottoNumber;
  String dateStart;
  String dateEnd;
  int price;
  int seleStatus;
  int lottoResultStatus;

  OrderGetResponse({
    required this.oid,
    required this.lid,
    required this.uid,
    required this.date,
    required this.paymentStatus,
    required this.lottoNumber,
    required this.dateStart,
    required this.dateEnd,
    required this.price,
    required this.seleStatus,
    required this.lottoResultStatus,
  });

  factory OrderGetResponse.fromMap(Map<String, dynamic> json) =>
      OrderGetResponse(
        oid: json["oid"],
        lid: json["lid"],
        uid: json["uid"],
        date: json["date"],
        paymentStatus: json["payment_status"],
        lottoNumber: json["lotto_number"],
        dateStart: json["date_start"],
        dateEnd: json["date_end"],
        price: json["price"],
        seleStatus: json["sele_status"],
        lottoResultStatus: json["lotto_result_status"],
      );

  Map<String, dynamic> toMap() => {
    "oid": oid,
    "lid": lid,
    "uid": uid,
    "date": date,
    "payment_status": paymentStatus,
    "lotto_number": lottoNumber,
    "date_start": dateStart,
    "date_end": dateEnd,
    "price": price,
    "sele_status": seleStatus,
    "lotto_result_status": lottoResultStatus,
  };
}
