import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // --- BARIS 1: PROFILE & PROMO ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Foto Profil (Kiri)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.0),
                ),
                child: const CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage(
                    'assets/images/dashboard/header/foto_profile.jpg',
                  ),
                ),
              ),

              // Bagian Kanan (Promo & Help)
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.percent, color: Color(0xFFED1C24), size: 14),
                        SizedBox(width: 4),
                        Text(
                          "Promo",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Icon(Icons.help_outline, color: Colors.white, size: 26),
                ],
              ),
            ],
          ),

          const SizedBox(height: 30),

          // --- BARIS 2: SALDO & POIN (Pakai Stack biar presisi) ---
          SizedBox(
            width: double.infinity, // Pastiin lebarnya full biar Stack jalan
            height: 30, // Kasih tinggi dikit biar muat chip-nya
            child: Stack(
              alignment: Alignment
                  .center, // Kuncinya disini: Teks Balance tetep di TENGAH
              children: [
                // 1. Label "Total Balance" + Icon Mata (Di Tengah)
                Row(
                  mainAxisSize:
                      MainAxisSize.min, // Biar lebarnya ngikutin konten aja
                  children: [
                    const Text(
                      "Total Balance",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Icon Mata (Hide Balance)
                    Icon(
                      Icons.visibility_off_outlined, // Icon mata dicoret
                      color: Colors.white.withOpacity(
                        0.8,
                      ), // Agak transparan dikit
                      size: 18,
                    ),
                  ],
                ),

                // 2. Chip Poin (Di Kanan Mentok)
                Positioned(
                  right: 0, // Tempel ke kanan
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        CircleAvatar(
                          backgroundColor: Colors.orange,
                          radius: 6,
                          child: Icon(
                            Icons.currency_lira,
                            color: Colors.white,
                            size: 8,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "10.000 >",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 5),

          // --- BARIS 3: NOMINAL SALDO ---
          const Text(
            "Rp 999.999.999",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
