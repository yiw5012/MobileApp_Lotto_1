// To parse this JSON data, do
//
//     final winingLottoAddPostReq = winingLottoAddPostReqFromJson(jsonString);

import 'dart:convert';

WiningLottoAddPostReq winingLottoAddPostReqFromJson(String str) => WiningLottoAddPostReq.fromJson(json.decode(str));

String winingLottoAddPostReqToJson(WiningLottoAddPostReq data) => json.encode(data.toJson());

class WiningLottoAddPostReq {
    int lid;
    String winningLottoNumber;
    int rank;
    String date;
    int prize;

    WiningLottoAddPostReq({
        required this.lid,
        required this.winningLottoNumber,
        required this.rank,
        required this.date,
        required this.prize,
    });

    factory WiningLottoAddPostReq.fromJson(Map<String, dynamic> json) => WiningLottoAddPostReq(
        lid: json["lid"],
        winningLottoNumber: json["winning_lotto_number"],
        rank: json["rank"],
        date: json["date"],
        prize: json["prize"],
    );

    Map<String, dynamic> toJson() => {
        "lid": lid,
        "winning_lotto_number": winningLottoNumber,
        "rank": rank,
        "date": date,
        "prize": prize,
    };
}
