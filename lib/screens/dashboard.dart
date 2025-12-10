import 'package:flutter/material.dart';

// --- IMPORT WIDGETS (Sesuaikan path lu) ---
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

  void _onNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: SingleChildScrollView(
        child: Stack(
          children: [
            // --- LAYER 1: BACKGROUND MERAH ---
            Container(
              // Pastikan height ini cukup panjang biar cover area saldo yang baru
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

                  // A. HEADER (Profile, Saldo, dll)
                  const DashboardHeader(),

                  // --- MODIFIKASI 2: JARAK ANTARA HEADER & BOX PUTIH DIKECILIN ---
                  // Tadi 60, sekarang gua ubah jadi 10 aja.
                  // Karena Header di atas udah makin tinggi (nambah spacing dalam),
                  // Spasi luar ini harus dikurangin biar Box Putih naik lagi.
                  const SizedBox(height: 15),

                  // B. MENU & ISI BAWAH (Stack)
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // -- BOX PUTIH (Container Utama) --
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
                            // 1. PAYMENT LIST
                            const PaymentList(),
                            const SizedBox(height: 20),

                            // 2. PROMO SLIDER
                            const PromoSlider(),
                            const SizedBox(height: 20),

                            Container(
                              height: 12,
                              width: double.infinity,
                              color: Colors.grey[100],
                            ),
                            const SizedBox(height: 10),

                            // 3. BEST DEALS
                            const BestDeals(),
                            const SizedBox(height: 10),

                            Container(
                              height: 12,
                              width: double.infinity,
                              color: Colors.grey[100],
                            ),
                            const SizedBox(height: 10),

                            // 4. LATEST UPDATES
                            const LatestUpdates(),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),

                      // -- QUICK MENU (Melayang) --
                      // Posisinya tetap nempel di atas Box Putih
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

      // 3. FLOATING ACTION BUTTON (QR)
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
                print("Scan QR Clicked");
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

      // 4. NAVBAR
      bottomNavigationBar: MenuNavbar(
        selectedIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}
