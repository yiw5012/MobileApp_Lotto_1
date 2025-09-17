// To parse this JSON data, do
//
//     final lottoInsertPostreq = lottoInsertPostreqFromJson(jsonString);

import 'dart:convert';

LottoInsertPostreq lottoInsertPostreqFromJson(String str) => LottoInsertPostreq.fromJson(json.decode(str));

String lottoInsertPostreqToJson(LottoInsertPostreq data) => json.encode(data.toJson());

class LottoInsertPostreq {
    int uid;
    String lottoNumber;
    String dateStart;
    String dateEnd;
    int price;
    int saleStatus;
    int lottoResultStatus;

    LottoInsertPostreq({
        required this.uid,
        required this.lottoNumber,
        required this.dateStart,
        required this.dateEnd,
        required this.price,
        required this.saleStatus,
        required this.lottoResultStatus,
    });

    factory LottoInsertPostreq.fromJson(Map<String, dynamic> json) => LottoInsertPostreq(
        uid: json["uid"],
        lottoNumber: json["lotto_number"],
        dateStart: json["date_start"],
        dateEnd: json["date_end"],
        price: json["price"],
        saleStatus: json["sale_status"],
        lottoResultStatus: json["lotto_result_status"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "lotto_number": lottoNumber,
        "date_start": dateStart,
        "date_end": dateEnd,
        "price": price,
        "sale_status": saleStatus,
        "lotto_result_status": lottoResultStatus,
    };
}
