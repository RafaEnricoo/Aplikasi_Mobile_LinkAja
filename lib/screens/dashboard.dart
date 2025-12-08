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
      
      // 2. BODY UTAMA
      body: Stack(
        children: [
          // A. BACKGROUND HEADER MERAH (Layer Terbawah)
          Container(
            height: 240,
            width: double.infinity,
            decoration: const BoxDecoration(
              // Jika background image belum ada, ganti warna solid dulu biar gak error
              // color: Color(0xFFE52326), 
              image: DecorationImage(
                image: AssetImage('assets/images/dashboard/header/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // B. KONTEN SCROLLABLE (Layer Atas)
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // 1. HEADER (Profile & Saldo)
                  // Pastikan class DashboardHeader menerima parameter jika butuh data dinamis
                  const DashboardHeader(),

                  const SizedBox(height: 20),

                  // 2. QUICK MENU (Box Melayang)
                  const QuickMenu(),

                  const SizedBox(height: 20),

                  // 3. CONTAINER PUTIH BAWAH (Rounded Top)
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
                        // Payment List Grid
                        const PaymentList(),

                        const SizedBox(height: 20),

                        // Promo Banner (Masih Inline, nanti dipisah ya!)
                        _buildSpecialForYou(),

                        // Spacer extra agar konten terbawah tidak tertutup Navbar
                        const SizedBox(height: 80), 
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

  // --- SISA WIDGET LOKAL (PROMO) ---
  // Idealnya dipindah ke lib/widgets/promo_slider.dart nanti
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
}