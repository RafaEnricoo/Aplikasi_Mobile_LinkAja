import 'package:flutter/material.dart';

// --- IMPORT WIDGETS ---
import '../widgets/header.dart';        // Pastikan nama file sesuai
import '../widgets/menu_quick.dart';    // Pastikan nama file sesuai
import '../widgets/payment_list.dart';  // Pastikan nama file sesuai
import '../widgets/menu_navbar.dart';   // <--- IMPORT NAVBAR YANG BARU

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // 1. STATE VARIABLE
  // Ini untuk melacak menu mana yang sedang aktif (0: Home, 1: History, dst)
  int _currentIndex = 0; 

  // Fungsi untuk mengubah halaman saat menu diklik
  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
              height: 280,
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
                            topLeft: Radius.circular(70),
                            topRight: Radius.circular(70),
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

      // 3. FLOATING ACTION BUTTON (Tombol QR Merah)
      floatingActionButton: SizedBox(
        width: 65,
        height: 65,
        child: FloatingActionButton(
          onPressed: () {
            print("Scan QR Clicked");
          },
          backgroundColor: const Color(0xFFE52326), // Merah LinkAja
          elevation: 4,
          shape: const CircleBorder(), // Wajib bulat agar pas di lekukan
          child: const Icon(Icons.qr_code_scanner, size: 32, color: Colors.white),
        ),
      ),
      // Lokasi tombol: Menancap di tengah navbar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 4. BOTTOM NAVIGATION BAR (Modular Widget)
      bottomNavigationBar: MenuNavbar(
        selectedIndex: _currentIndex, // Lempar state ke widget
        onTap: _onNavBarTap,          // Lempar fungsi update state ke widget
      ),
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
              color: Colors.blue[100], // Placeholder color
              image: const DecorationImage(
                // Ganti dengan aset lokal jika sudah ada
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
