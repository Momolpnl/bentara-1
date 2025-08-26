import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class KelolaDataPage extends StatefulWidget {
  const KelolaDataPage({super.key});

  @override
  State<KelolaDataPage> createState() => _KelolaDataPageState();
}

class _KelolaDataPageState extends State<KelolaDataPage> {
  int _jumlahData = 0;

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  Future<void> _loadCSV() async {
    try {
      final rawData = await rootBundle.loadString("assets/data/data.csv");
      final rows = const CsvToListConverter().convert(rawData);

      setState(() {
        _jumlahData = rows.length > 1 ? rows.length - 1 : 0; // skip header
      });
    } catch (e) {
      setState(() {
        _jumlahData = 0;
      });
    }
  }

  Future<void> _updateData() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/data.csv";
    final file = File(path);

    List<List<dynamic>> rows = [];

    if (await file.exists()) {
      final csvContent = await file.readAsString();
      rows = const CsvToListConverter().convert(csvContent);
    } else {
      rows.add(["id", "nama", "lokasi"]);
    }

    rows.add([rows.length, "Trafo Baru", "Lokasi X"]);
    final csv = const ListToCsvConverter().convert(rows);
    await file.writeAsString(csv);

    _loadCSV();
  }

  Future<void> _bersihkanData() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/data.csv"; // <-- aku benerin path biar ga nyasar
    final file = File(path);

    if (await file.exists()) {
      await file.delete();
    }

    setState(() {
      _jumlahData = 0;
    });
  }

  // ======== POPUP UPLOAD ========
  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F4FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_upload, size: 80, color: Color(0xFF395886)),
                const SizedBox(height: 10),
                const Text(
                  "Masukkan Data Baru",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF395886)),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF395886),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _updateData();
                  },
                  child: const Text("Upload data"),
                ),
                const SizedBox(height: 8),
                const Text("*Pastikan file dalam bentuk .CSV", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        );
      },
    );
  }

  // ======== POPUP HAPUS ========
  void _showHapusDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.delete_forever, size: 80, color: Colors.red),
                const SizedBox(height: 10),
                const Text(
                  "Semua Data Akan Terhapus",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Yakin ingin tetap melakukan pembersihan data?",
                  style: TextStyle(color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _bersihkanData();
                  },
                  child: const Text("Hapus data"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFCEE3FF), Color(0xFF628ECB), Color(0xFFCEE3FF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: const Center(
                  child: Text(
                    "BENTARA",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFFEFFAF),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Judul
              const Text(
                "Kelola Data",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF395886),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Card jumlah data trafo
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFD5),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.bar_chart, size: 100, color: Color(0xFF395886)),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Jumlah Data Trafo",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF395886),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "$_jumlahData data",
                          style: const TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF395886),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Tombol Update Data (pakai popup)
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 230,
                  child: ElevatedButton.icon(
                    onPressed: _showUploadDialog,
                    icon: const Icon(Icons.upload, size: 25),
                    label: const Text("Update data", style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF86E49F),
                      foregroundColor: const Color(0xFF395886),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Tombol Bersihkan Data (pakai popup)
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 230,
                  child: ElevatedButton.icon(
                    onPressed: _showHapusDialog,
                    icon: const Icon(Icons.delete_forever, size: 25),
                    label: const Text("Bersihkan data", style: TextStyle(fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFA5B5B),
                      foregroundColor: const Color(0xFFFFFFD5),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
