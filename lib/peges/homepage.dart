import 'package:flutter/material.dart';
import 'package:lotto_1/peges/Member.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ลอตเตอรี่',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'งวดวันที่ 16 สิงหาคม 2568',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 250,
                    height: 150,
                    color: Colors.white,

                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),

                              child: Container(
                                width: 25,
                                height: 25,
                                color: Colors.blue,
                                alignment: Alignment.center,
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Action for the button
                              },
                              child: const Text('สุ่มหวย'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Action for the button
                              },
                              child: const Text('ค้นหาเลข'),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Action for the button
                          },
                          child: const Text('ตรวจสลากของคุณ'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Card(
                margin: const EdgeInsets.all(20),
                child: SizedBox(
                  // boxใหญ่
                  width: 300,
                  height: 150,
                  child: Image.network(
                    'https://static.thairath.co.th/media/dFQROr7oWzulq5Fa5K4BG1afANvfhsI0uwEO1wESe3ZeLKGyfPL4Ti6DjFSG9nsKQwF.jpg',
                    // รูปภาพ
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Card(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.home), onPressed: home),
            const IconButton(icon: Icon(Icons.class_sharp), onPressed: null),
            const IconButton(icon: Icon(Icons.navigation), onPressed: null),
            IconButton(icon: const Icon(Icons.person), onPressed: member),
          ],
        ),
      ),
    );
  }

  void home() {}

  void member() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Member()));
  }
}
