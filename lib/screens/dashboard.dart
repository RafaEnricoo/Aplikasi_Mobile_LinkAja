import 'package:flutter/material.dart';

// --- IMPORT SCREEN LAIN ---
import 'history.dart';
import 'scan_qris_screen.dart';
import 'account_screen.dart';

// --- IMPORT WIDGETS DASHBOARD ---
import '../widgets/dashboard/header.dart';
import '../widgets/dashboard/menu_quick.dart';
import '../widgets/dashboard/payment_list.dart';
import '../widgets/menu_navbar.dart';
import '../widgets/dashboard/promo_slider.dart';
import '../widgets/dashboard/best_deals.dart';
import '../widgets/dashboard/latest_update.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  // Daftar Halaman untuk Navigasi
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeContent(), // Index 0: Halaman Dashboard/Home
      const HistoryScreen(), // Index 1: Halaman History (Yang tadi dibuat)
      const Center(child: Text("Inbox Page")), // Index 2: Placeholder
      const AccountScreen(), // Index 3: Placeholder
    ];
  }

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // --- INI SOLUSINYA ---
      // false = Layout TIDAK akan terdorong naik saat keyboard muncul
      // Jadi tombol QR dan Navbar bakal tetap di bawah (ketutup keyboard)
      resizeToAvoidBottomInset: false,

      // Body menggunakan IndexedStack agar halaman tidak reload saat pindah tab
      body: IndexedStack(index: _currentIndex, children: _pages),

      // TOMBOL QR (Floating Action Button)
      floatingActionButton: SizedBox(
        width: 65,
        height: 65,
        child: Material(
          shape: const CircleBorder(),
          elevation: 4,
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFF5555), Color(0xFFE52326)],
                stops: [0.0, 0.4],
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScanQrisScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Image.asset(
                  'assets/images/dashboard/navbar/qr.png',
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // NAVBAR
      bottomNavigationBar: MenuNavbar(
        selectedIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}

// ---------------------------------------------------------
// WIDGET KONTEN HOME (DASHBOARD)
// Dipisah di sini biar rapi
// ---------------------------------------------------------
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          // --- LAYER 1: BACKGROUND MERAH ---
          Container(
            height: 380,
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
                const SizedBox(height: 20),

                // Header Dashboard (Saldo, Nama user, dll)
                const DashboardHeader(),

                const SizedBox(height: 15),

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // -- BOX PUTIH --
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 40),
                      padding: const EdgeInsets.only(top: 80, bottom: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const PaymentList(),
                          const SizedBox(height: 20),
                          const PromoSlider(),
                          const SizedBox(height: 20),
                          Container(height: 12, color: Colors.grey[100]),
                          const SizedBox(height: 10),
                          const BestDeals(),
                          const SizedBox(height: 10),
                          Container(height: 12, color: Colors.grey[100]),
                          const SizedBox(height: 10),
                          const LatestUpdates(),
                          const SizedBox(height: 60), // Space bawah
                        ],
                      ),
                    ),

                    // -- QUICK MENU (Icon Grid) --
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
    );
  }
}
