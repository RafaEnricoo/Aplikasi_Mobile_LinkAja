import 'package:flutter/material.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // PADDING UPDATED:
      // Top: 80 (biar header tetap kerasa tinggi/panjang ke bawah)
      // Bottom: 20 (biar search bar mepet sama batas bawah background)
      padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/history/header.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // --- BARIS 1: JUDUL & ICON CHAT ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Spacer kiri (biar judul di tengah)
              const SizedBox(width: 24),

              // Judul
              const Text(
                'Transaction History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Icon Chat (sejajar sama judul)
              const Icon(Icons.chat_bubble_outline, color: Colors.white),
            ],
          ),

          // JARAK ANTARA JUDUL & SEARCH (Dikecilin biar mepet)
          const SizedBox(height: 25),

          // --- BARIS 2: SEARCH BAR + FILTER ICON ---
          Row(
            children: [
              // Search Bar
              Expanded(
                child: Container(
                  height:
                      35, // Tinggi search bar gua kecilin dikit biar proporsional
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const TextField(
                    textAlignVertical:
                        TextAlignVertical.center, // Teks di tengah vertikal
                    decoration: InputDecoration(
                      hintText: 'Search send money..',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 22,
                      ),
                      border: InputBorder.none,
                      // Content padding diset biar pas tengah
                      contentPadding: EdgeInsets.symmetric(vertical: 9),
                      isDense: true,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 15),

              // Tombol Filter (Ikon Putih)
              // Sejajar secara horizontal dengan search bar
              InkWell(
                onTap: () => print("Filter clicked"),
                child: const Icon(Icons.tune, color: Colors.white, size: 28),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
