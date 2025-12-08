import 'package:flutter/material.dart';

// --- IMPORT KOMPONEN YANG UDAH LU PISAH ---
// Pastikan path/lokasi foldernya sesuai ya
import '../widgets/header.dart';
import '../widgets/menu_quick.dart';
import '../widgets/payment_list.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // 1. SingleChildScrollView DI LUAR
      // Ini kuncinya biar background merah ikut kegulung pas discroll
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // --- LAYER 1: BACKGROUND IMAGE (Header Merah) ---
            // Posisinya paling belakang
            Container(
              height: 275,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/dashboard/header/background.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // --- LAYER 2: KONTEN UTAMA ---
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // A. HEADER (Profile, Saldo, dll)
                  const DashboardHeader(),

                  const SizedBox(height: 10),

                  // B. MENU & ISI BAWAH (Pakai Stack lagi buat efek Floating)
                  Stack(
                    clipBehavior: Clip.none, // Biar shadow/offset gak kepotong
                    children: [
                      // -- BOX PUTIH (Payment List) --
                      Container(
                        width: double.infinity,
                        // Turunin dikit (40px) biar Quick Menu di atasnya bisa "ngangkang"
                        margin: const EdgeInsets.only(top: 40),
                        // Padding top gede (60px) biar isi list gak ketutup Quick Menu
                        padding: const EdgeInsets.only(top: 80, bottom: 20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Panggil Component PaymentList
                            const PaymentList(),

                            const SizedBox(height: 20),

                            // Panggil Promo Banner
                            _buildSpecialForYou(),

                            const SizedBox(height: 80), // Spacer bawah
                          ],
                        ),
                      ),

                      // -- QUICK MENU (Melayang di Atas) --
                      const Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: QuickMenu(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // --- TOMBOL QR ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFED1C24),
        elevation: 4,
        child: const Icon(Icons.qr_code_scanner, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // --- BOTTOM NAVBAR ---
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // --- WIDGET PROMO BANNER (Manual di sini) ---
  Widget _buildSpecialForYou() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Special Just For You!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 15),
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: NetworkImage("https://via.placeholder.com/600x300"),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET NAVBAR (Manual di sini) ---
  Widget _buildBottomNavBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, "Home", true),
            _navItem(Icons.history, "History", false),
            const SizedBox(width: 40),
            _navItem(Icons.mail_outline, "Inbox", false),
            _navItem(Icons.person_outline, "Account", false),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isActive ? Colors.red : Colors.grey[400]),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? Colors.red : Colors.grey[400],
          ),
        ),
      ],
    );
  }
}
