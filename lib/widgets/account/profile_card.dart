import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // REVISI 1: Margin ditambah dari 20 jadi 24 biar gak terlalu mepet pinggir
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // --- FOTO PROFIL (DIPERMAK) ---
          Container(
            // REVISI 2: Ukuran dikecilin dikit (tadi 60, sekarang 54)
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,

              // REVISI 3: Tambah Stroke/Garis Tepi Putih
              border: Border.all(
                color: Colors.white,
                width: 2.0, // Ketebalan garis putih
              ),

              // REVISI 4: Tambah Shadow khusus di belakang foto
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Bayangan agak gelap
                  blurRadius: 8,
                  offset: const Offset(0, 4), // Bayangan jatuh ke bawah
                ),
              ],

              image: const DecorationImage(
                image: AssetImage('assets/images/account/foto_profile.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(
            width: 20,
          ), // Jarak antara foto dan teks agak dilegain dikit
          // --- NAMA & INFO ---
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rafa Hamim Enrico",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "+628123456789",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
