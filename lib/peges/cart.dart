import 'package:flutter/material.dart';

class Cartpage extends StatelessWidget {
  const Cartpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ---------- AppBar ----------
      appBar: AppBar(title: const Text("กลับสู่หน้าหลัก"), centerTitle: false),

      // ---------- Body ----------
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- แถบขั้นตอน ---
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pinkAccent, Colors.red],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  StepItem(
                    icon: Icons.shopping_cart,
                    label: "ตะกร้า",
                    active: true,
                  ),
                  StepItem(icon: Icons.attach_money, label: "ชำระเงิน"),
                  StepItem(icon: Icons.check_circle, label: "สำเร็จ"),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // --- Card ลอตเตอรี่ ---
            // --- Card ลอตเตอรี่ ---
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.stretch, // ให้เต็มความกว้าง
                children: [
                  // --- รูปภาพลอตเตอรี่ ---
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                    child: Image.network(
                      "https://s359.kapook.com/pagebuilder/e9389651-319a-4b69-a69c-2f3ad413b6cc.jpg",
                      width: double.infinity, // ให้เต็ม card
                      height: 200, // กำหนดความสูงที่เหมาะสม
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- ข้อความรายละเอียดลอตเตอรี่ ---
                        Text(
                          "123456                                                             80 บาท",
                        ),
                        Text(
                          "ลอตเตอรี่                                                             1 ใบ",
                        ),
                        Text(
                          "ราคา                                                                  80 บาท",
                        ),
                        Text(
                          "ยอดรวมทั้งหมด                                                 80 บาท",
                        ),
                        const SizedBox(height: 12),
                        // --- ปุ่มลบ + ซื้อ ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red, // สีพื้นหลังปุ่ม
                                foregroundColor: Colors.white, // สีตัวหนังสือ
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("ซื้อลอตเตอรี่"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- ปุ่มเลือกซื้อเพิ่ม ---
            Padding(
              padding: const EdgeInsets.all(12),
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("เลือกซื้อลอตเตอรี่ต่อ"),
              ),
            ),
          ],
        ),
      ),

      // ---------- Bottom Navigation ----------
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.home), onPressed: () {}),
            IconButton(icon: const Icon(Icons.class_sharp), onPressed: () {}),
            IconButton(icon: const Icon(Icons.navigation), onPressed: () {}),
            IconButton(icon: const Icon(Icons.person), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

// ---------- Widget ย่อย: StepItem ----------
class StepItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const StepItem({
    super.key,
    required this.icon,
    required this.label,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: active ? Colors.white : Colors.white70),
        Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.white70,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
