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
            width: double.infinity,
            height: 30,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 1. Label "Total Balance" + Icon Mata (Di Tengah)
                Row(
                  mainAxisSize: MainAxisSize.min,
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
                      Icons.visibility_off_outlined,
                      color: Colors.white.withOpacity(0.8),
                      size: 18,
                    ),
                  ],
                ),

                // 2. Chip Poin (Di Kanan Mentok)
                Positioned(
                  right: 0,
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

          // --- BARIS 3: NOMINAL SALDO (YANG DIPERBAIKI) ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Posisi di tengah
            crossAxisAlignment: CrossAxisAlignment.start, // "Rp" nempel di atas
            children: [
              // 1. Bagian "Rp" (Kecil)
              Padding(
                padding: const EdgeInsets.only(
                  top: 4.0,
                ), // Geser dikit ke bawah
                child: const Text(
                  "Rp",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14, // Font kecil
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 4), // Jarak spasi
              // 2. Bagian Angka (Besar)
              const Text(
                "999.999.999",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32, // Font besar
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  height: 1.0, // Ratin line height
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
