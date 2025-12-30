import 'package:flutter/material.dart';
import '../widgets/account/account_menu_tile.dart';
import '../widgets/account/profile_card.dart';
import 'landing_page.dart'; // 1. PASTIKAN IMPORT INI ADA

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HEADER MERAH + PROFILE CARD ---
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                // Background Merah (Pendek)
                Container(
                  height: 140, // Tinggi header merah
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    bottom: 40,
                  ), // Ruang buat kartu melayang
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      // Reuse background header yang lama
                      image: AssetImage('assets/images/history/header.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Kartu Profil Melayang
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ProfileCard(),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --- MENU SECTIONS ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GROUP 1: My Account
                  _buildSectionLabel("My Account"),
                  _buildMenuContainer([
                    AccountMenuTile(
                      icon: Icons.account_circle_outlined,
                      title: "Account Type",
                      trailingText: "Full Service",
                      onTap: () {},
                    ),
                    _divider(),
                    AccountMenuTile(
                      icon: null,
                      iconAsset: 
                          'assets/images/account/icon_setting.png',
                      title: "Account Settings",
                      onTap: () {},
                    ),
                    _divider(),
                    AccountMenuTile(
                      icon: null,
                      iconAsset:
                          'assets/images/account/icon_linkaja_syariah.png',
                      title: "LinkAja Syariah",
                      trailingText: "Not Active",
                      onTap: () {},
                    ),
                    _divider(),
                    AccountMenuTile(
                      icon: Icons.payment,
                      title: "Payment Methods",
                      onTap: () {},
                    ),
                    _divider(),
                    AccountMenuTile(
                      icon: Icons.hub_outlined, // Icon Connected Apps
                      title: "Connected Apps",
                      onTap: () {},
                    ),
                  ]),

                  const SizedBox(height: 20),

                  // GROUP 2: Security & Privacy
                  _buildSectionLabel("Security & Privacy"),
                  _buildMenuContainer([
                    AccountMenuTile(
                      icon: Icons.email_outlined,
                      title: "Email",
                      trailingText: "mrafahamim@gmail.com",
                      onTap: () {},
                    ),
                    _divider(),
                    AccountMenuTile(
                      icon: Icons.security,
                      title: "Security Question",
                      trailingText: "Not Set",
                      onTap: () {},
                    ),
                    _divider(),
                    AccountMenuTile(
                      icon: Icons.password, // Icon PIN
                      title: "PIN Settings",
                      onTap: () {},
                    ),
                    _divider(),
                    AccountMenuTile(
                      icon: Icons.language,
                      title: "Language",
                      trailingText: "English",
                      onTap: () {},
                    ),
                  ]),

                  const SizedBox(height: 20),

                  // GROUP 3: Help & Policies
                  _buildSectionLabel("Help & Policies"),
                  _buildMenuContainer([
                    AccountMenuTile(
                      icon: Icons.headset_mic_outlined,
                      title: "Terms of Service",
                      onTap: () {},
                    ),
                    _divider(),
                    AccountMenuTile(
                      icon: Icons.privacy_tip_outlined,
                      title: "Privacy Policy",
                      onTap: () {},
                    ),
                    _divider(),
                    AccountMenuTile(
                      icon: Icons.help_outline,
                      title: "Help Center",
                      onTap: () {},
                    ),
                  ]),

                  const SizedBox(height: 30),

                  // TOMBOL LOGOUT (UPDATED)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      // PANGGIL FUNGSI DIALOG DI SINI
                      onPressed: () {
                        _showLogoutDialog(context); 
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        "Log Out",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Spasi Bawah biar gak ketutup navbar
                  const SizedBox(height: 130),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Judul Section (My Account, Security, dll)
  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 4),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Helper Widget: Kotak Putih Pembungkus Menu
  Widget _buildMenuContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  // Helper Widget: Garis Pemisah Tipis
  Widget _divider() {
    return Divider(
      height: 1,
      thickness: 0.5,
      color: Colors.grey.shade200,
      indent: 16, // Biar garisnya gak mentok kiri
      endIndent: 16,
    );
  }
}

// Fungsi untuk memunculkan Bottom Sheet Konfirmasi Logout
  void _showLogoutDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Agar tinggi menyesuaikan isi konten (tidak default setengah layar)
      backgroundColor: Colors.transparent, // Transparan agar kita bisa atur lengkungan sudut sendiri
      builder: (context) {
        return Container(
          // Dekorasi Panel Putih
          decoration: const BoxDecoration(
            color: Colors.white,
            // Lengkungan hanya di sudut kiri atas & kanan atas
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          // Padding di dalam sheet
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 40), 
          
          child: Column(
            mainAxisSize: MainAxisSize.min, // Tinggi menyesuaikan konten
            children: [
              // 1. BAGIAN ATAS: ICON + TEKS
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon Logout
                  Image.asset(
                    'assets/images/account/logout.png',
                    width: 50, 
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 16),
                  
                  // Teks
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Logout from your account?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Make sure you remember your account’s PIN to login again later!",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30), // Jarak ke tombol

              // 2. BAGIAN BAWAH: TOMBOL AKSI
              Row(
                children: [
                  // TOMBOL YES (Outline Merah)
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context); // Tutup Sheet
                          
                          // Logout & Pindah ke Landing
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LandingPage()),
                            (route) => false,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFE52326)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          foregroundColor: const Color(0xFFE52326),
                        ),
                        child: const Text(
                          "Yes, Logout",
                          style: TextStyle(
                            color: Color(0xFFE52326),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),

                  // TOMBOL CANCEL (Full Merah)
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Tutup sheet
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE52326),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }