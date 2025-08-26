import 'package:flutter/material.dart';

class InformasiULPPage extends StatelessWidget {
  const InformasiULPPage({super.key});

  @override
  Widget build(BuildContext context) {
    // contoh data dummy
    final daftarULP = [
      {"ulp": "ULP Lhokseumawe", "lt": "123", "bj": "456", "kecamatan": "10", "desa": "50"},
      {"ulp": "ULP Bireun", "lt": "789", "bj": "321", "kecamatan": "5", "desa": "25"},
      {"ulp": "ULP Geudong", "lt": "654", "bj": "987", "kecamatan": "8", "desa": "40"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFCEE3FF), // kiri
                    Color(0xFF628ECB), // tengah
                    Color(0xFFCEE3FF), // kanan
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: const Center(
                child: Text(
                  "BENTARA",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFEFFAF),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

              // JUDUL
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.article, color: Color(0xFF395886), size: 50),
                  SizedBox(width: 8),
                  Text(
                    "Informasi ULP",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF395886),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: daftarULP.length,
                itemBuilder: (context, index) {
                  var data = daftarULP[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.blue),
                      title: Text(data["ulp"]!),
                      subtitle: Text("Jumlah Desa: ${data["desa"]}"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailULPPage(data: data),
                          ),
                        );
                      },
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

class DetailULPPage extends StatelessWidget {
  final Map<String, String> data;
  const DetailULPPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data["ulp"]!),
        backgroundColor: Colors.lightBlue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey.shade300,
              child: const Center(child: Text("MAP / Gambar ULP")),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("LT : ${data["lt"]}"),
                  Text("BJ : ${data["bj"]}"),
                  Text("Jumlah Kecamatan : ${data["kecamatan"]}"),
                  Text("Jumlah Desa : ${data["desa"]}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
