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
                      // 2. UPDATE LOGIKA DISINI
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LandingPage()),
                          (route) => false, // Hapus semua stack halaman sebelumnya
                        );
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