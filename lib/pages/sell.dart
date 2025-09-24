import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lotto_1/config/config.dart';
import 'package:lotto_1/model/response/winning_lotto_res.dart';

class Sell extends StatefulWidget {
  const Sell({super.key});

  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  List<WinningLotto> winningLottos = [];
  bool isLoading = false;
  String url = '';
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
    });
  }

  Future<void> fetchWinningLotto() async {
    String date = dateController.text.trim();
    if (date.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("กรุณากรอกวันที่ (yyyy-MM-dd)")),
      );
      return;
    }

    setState(() {
      isLoading = true;
      winningLottos = [];
    });

    try {
      final res = await http.get(
        Uri.parse('$url/lotto/winning_lotto/date/$date'),
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
      appBar: AppBar(title: const Text("ผลรางวัลลอตเตอรี่")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // --- Input วันที่ ---
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: "กรอกวันที่ (yyyy-MM-dd)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // --- ปุ่มค้นหา ---
            ElevatedButton(
              onPressed: fetchWinningLotto,
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
                                Text(
                                  "งวดวันที่: ${lotto.date}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
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
