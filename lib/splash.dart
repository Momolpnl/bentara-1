import 'package:flutter/material.dart';
import 'home.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFA9C1E3), // atas
                  Color(0xFFCDDAEF), // tengah
                  Color(0xFFF0F3FA), // bawah
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gambar ilustrasi
                Image.asset(
                  "assets/images/bentara.png",
                  width: 452,
                  height: 452,
                ),

                // Jarak kecil antara gambar dan judul
                const SizedBox(height: 8),

                // Judul besar dengan gradient
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFF628ECB),
                      Color(0xFF4E73A9),
                      Color(0xFF395886),
                      Color(0xFF4E73A9),
                      Color(0xFF628ECB),
                    ],
                    stops: [0.0, 0.15, 0.5, 0.85, 1.0],
                  ).createShader(Rect.fromLTWH(0, 0, 300, 70)),
                  child: const Text(
                    "BENTARA",
                    style: TextStyle(
                      fontSize: 64,
                      fontFamily: "Sen",
                      fontWeight: FontWeight.w800,
                      color: Colors.white, // wajib putih biar kelihatan gradasi
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Subjudul
                const Text(
                  "Kalkulator Bentangan & Informasi\nGardu Untuk Akselerasi PB/PD",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Sen",
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF628ECB),
                  ),
                ),

                const Spacer(),

                // Footer
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Text(
                        "NPS LSM x IT PNL",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Sen",
                          fontWeight: FontWeight.w100,
                          color: Color(0xFF628ECB),
                        ),
                      ),
                      Text(
                        "2025",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Sen",
                          fontWeight: FontWeight.w100,
                          color: Color(0xFF628ECB),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
