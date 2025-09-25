import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_1/config/config.dart';
import 'package:lotto_1/model/response/winning_lotto_res.dart';
import 'dart:convert';

class Sell extends StatefulWidget {
  const Sell({super.key});

  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  List<WinningLotto> winningLottos = [];
  bool isLoading = false;
  String url = '';

  // สำหรับ dropdown
  List<String> availableDates = [];
  String? selectedDate;
  TextEditingController dateController = TextEditingController();

  final Map<int, String> thaiMonths = {
    1: "มกราคม",
    2: "กุมภาพันธ์",
    3: "มีนาคม",
    4: "เมษายน",
    5: "พฤษภาคม",
    6: "มิถุนายน",
    7: "กรกฎาคม",
    8: "สิงหาคม",
    9: "กันยายน",
    10: "ตุลาคม",
    11: "พฤศจิกายน",
    12: "ธันวาคม",
  };

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
      fetchAvailableDates();
    });
  }

  // ดึงวันที่ทั้งหมดจาก backend
  Future<void> fetchAvailableDates() async {
    try {
      final res = await http.get(Uri.parse('$url/lotto/winning_lotto/date'));
      if (res.statusCode == 200) {
        List<dynamic> datesJson = jsonDecode(res.body);
        List<String> dates = datesJson.map((e) => e.toString()).toList();

        // sort วันจริง (เก่า → ใหม่)
        dates.sort((a, b) {
          DateTime da = DateTime.parse(a);
          DateTime db = DateTime.parse(b);
          return da.compareTo(db);
        });

        setState(() {
          availableDates = dates;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('โหลดวันที่ล้มเหลว: ${res.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('โหลดวันที่ล้มเหลว: $e')));
    }
  }

  // ดึงผลรางวัลตามวันที่
  Future<void> fetchWinningLotto() async {
    if (selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("กรุณาเลือกวันที่")));
      return;
    }

    setState(() {
      isLoading = true;
      winningLottos = [];
    });

    try {
      final res = await http.get(
        Uri.parse('$url/lotto/winning_lotto/date/$selectedDate'),
      );

      if (res.statusCode == 200) {
        setState(() {
          winningLottos = winningLottoFromJson(res.body);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ไม่พบผลรางวัล: ${res.statusCode}')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('เกิดข้อผิดพลาด: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: const Text(
          "ผลรางวัลลอตเตอรี่",
          style: TextStyle(
            color: Colors.white,
            // fontWeight: FontWeight.bold,
            // fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // --- Dropdown เลือกวันที่ ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.5),
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: DropdownButton<String>(
                hint: const Text(
                  "เลือกงวด",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                value: selectedDate,
                isExpanded: true,
                underline: const SizedBox(),
                dropdownColor: Colors.white, // สีพื้นหลัง dropdown
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.redAccent,
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black, // สีตัวอักษร item
                ),
                items: availableDates.map((dateString) {
                  DateTime dt = DateTime.parse(dateString);
                  String formatted =
                      "งวดวันที่ ${dt.day} เดือน ${thaiMonths[dt.month]} ปี ${dt.year}";

                  return DropdownMenuItem<String>(
                    value: dateString,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            formatted,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),

                onChanged: (value) {
                  setState(() {
                    selectedDate = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 12),

            // --- ปุ่มค้นหา ---
            ElevatedButton(
              onPressed: fetchWinningLotto,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("ค้นหาผลรางวัล"),
            ),
            const SizedBox(height: 12),

            // --- แสดงผล ---
            isLoading
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : winningLottos.isEmpty
                ? const Expanded(child: Center(child: Text("ยังไม่มีผลรางวัล")))
                : Expanded(
                    child: ListView.builder(
                      itemCount: winningLottos.length,
                      itemBuilder: (context, index) {
                        final lotto = winningLottos[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "รางวัลที่ ${lotto.rank}",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "เลขที่ถูกรางวัล: ${lotto.winningLottoNumber}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "เงินรางวัล: ${lotto.prize} บาท",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 6),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
