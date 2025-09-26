import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(const SnackBar(content: Text("กรุณาเลือกวันที่")));
      // Get.snackbar("กรุณาเลือกวันที่", "ไม่สามารถค้นหาได้");
      Get.snackbar(
        "กรุณาเลือกวันที่", // title
        "ไม่สามารถค้นหาได้", // message
        snackPosition: SnackPosition.TOP, // โชว์ด้านบน
        backgroundColor: const Color.fromARGB(255, 205, 11, 11), // สีพื้นหลัง
        colorText: Colors.white, // สีข้อความ
        icon: const Icon(Icons.check_circle, color: Colors.white), // ใส่ไอคอน
        borderRadius: 12, // มุมโค้ง
        margin: const EdgeInsets.all(16), // เว้นขอบรอบๆ
        duration: const Duration(seconds: 3), // เวลาโชว์
        animationDuration: const Duration(milliseconds: 500), // animation
        snackStyle: SnackStyle.FLOATING, // ให้ลอย ไม่ติดขอบ
      );
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
          style: TextStyle(color: Colors.white),
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
                hint: const Text("เลือกงวด"),
                value: (availableDates.isEmpty) ? 'no_date' : selectedDate,
                isExpanded: true,
                underline: const SizedBox(),
                dropdownColor: Colors.white,
                items: availableDates.isEmpty
                    ? [
                        const DropdownMenuItem<String>(
                          value: 'no_date',
                          child: Text("ไม่มีงวดที่ออก"),
                        ),
                      ]
                    : availableDates.map((dateString) {
                        DateTime dt = DateTime.parse(dateString);
                        String formatted =
                            "งวดวันที่ ${dt.day} เดือน ${thaiMonths[dt.month]} ปี ${dt.year}";
                        return DropdownMenuItem<String>(
                          value: dateString,
                          child: Text(formatted),
                        );
                      }).toList(),
                onChanged: (availableDates.isEmpty)
                    ? null
                    : (value) {
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

                        // --- เลขที่ถูกรางวัล ---
                        String winningNumber;
                        if (lotto.rank == 4) {
                          // เลขท้าย 3 ตัวจากรางวัลที่ 1
                          final firstPrize = winningLottos
                              .firstWhere((e) => e.rank == 1)
                              .winningLottoNumber;
                          winningNumber = firstPrize.substring(
                            firstPrize.length - 3,
                            firstPrize.length,
                          );
                        } else if (lotto.rank == 5) {
                          // เลขท้าย 2 ตัว
                          winningNumber = lotto.winningLottoNumber.substring(
                            lotto.winningLottoNumber.length - 2,
                          );
                        } else {
                          winningNumber = lotto.winningLottoNumber;
                        }

                        // --- ชื่อรางวัล ---
                        String rankName;
                        if (lotto.rank == 4) {
                          rankName = "เลขท้าย 3 ตัว";
                        } else if (lotto.rank == 5) {
                          rankName = "เลขท้าย 2 ตัว";
                        } else {
                          rankName = "รางวัลที่ ${lotto.rank}";
                        }

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
                                  rankName,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "เลขที่ถูกรางวัล: $winningNumber",
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
