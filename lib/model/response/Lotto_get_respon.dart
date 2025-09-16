class LottoGetRespon {
  int lid;
  int uid;
  int lottoNumber;
  DateTime dateStart;
  DateTime dateEnd;
  int price;
  int seleStatus;
  int lottoResultStatus;

  LottoGetRespon(
    String body, {
    required this.lid,
    required this.uid,
    required this.lottoNumber,
    required this.dateStart,
    required this.dateEnd,
    required this.price,
    required this.seleStatus,
    required this.lottoResultStatus,
  });
}
