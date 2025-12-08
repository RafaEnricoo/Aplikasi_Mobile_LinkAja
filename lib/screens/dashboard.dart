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
      backgroundColor: Colors.grey[100], // Warna background dasar (abu muda)
      body: Stack(
        children: [
          // 1. BACKGROUND IMAGE (Header Merah)
          // Tetap di sini karena dia jadi background utamanya
          Container(
            height: 240,
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

          // 2. KONTEN UTAMA
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // A. HEADER (Profile & Saldo)
                  // ✅ Panggil Class dari file dashboard_header.dart
                  const DashboardHeader(),

                  const SizedBox(height: 20),

                  // B. QUICK MENU (Box Melayang)
                  // ✅ Panggil Class dari file quick_menu.dart
                  const QuickMenu(),

                  const SizedBox(height: 20),

                  // C. CONTAINER PUTIH BAWAH (Payment List & Promo)
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ Panggil Class dari file payment_list.dart
                        const PaymentList(),

                        const SizedBox(height: 20),

                        // D. PROMO BANNER (Masih Inline/Lokal)
                        // Karena lu belum pisahin ini, kodenya tetep ditaruh di bawah (private method)
                        _buildSpecialForYou(),

                        const SizedBox(
                          height: 80,
                        ), // Spacer biar gak ketutup navbar
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

  // --- SISA WIDGET YANG BELUM DIPISAH (Promo & Navbar) ---

  // Widget Promo Banner
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

  // Widget Bottom Navbar
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
