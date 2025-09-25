import 'dart:convert';

List<WinningLotto> winningLottoFromJson(String str) => List<WinningLotto>.from(
  json.decode(str).map((x) => WinningLotto.fromJson(x)),
);

String winningLottoToJson(List<WinningLotto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WinningLotto {
  int wid;
  int lid;
  String winningLottoNumber;
  int rank;
  String date;
  int prize;

  WinningLotto({
    required this.wid,
    required this.lid,
    required this.winningLottoNumber,
    required this.rank,
    required this.date,
    required this.prize,
  });

  factory WinningLotto.fromJson(Map<String, dynamic> json) => WinningLotto(
    wid: json['wid'],
    lid: json['lid'],
    winningLottoNumber: json['winning_lotto_number'],
    rank: json['rank'],
    date: json['date'],
    prize: json['prize'],
  );

  Map<String, dynamic> toJson() => {
    'wid': wid,
    'lid': lid,
    'winning_lotto_number': winningLottoNumber,
    'rank': rank,
    'date': date,
    'prize': prize,
  };
}

List<String> winningDatesFromJson(String str) {
  final List<dynamic> jsonData = json.decode(str);
  return jsonData
      .map((x) => WinningLotto.fromJson(x).date)
      .toSet() // กันวันที่ซ้ำ
      .toList();
}
