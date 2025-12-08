import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Warna dasar abu muda
      body: Stack(
        children: [
          // 1. BACKGROUND IMAGE (Header Merah)
          Container(
            height: 400, // Tinggi background merah
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                // Pastiin path ini bener sesuai assets lu
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

                  // --- BAGIAN HEADER (Profile & Saldo) ---
                  _buildHeader(),

                  const SizedBox(height: 20),

                  // --- BAGIAN MENU MELAYANG (Quick Menu) ---
                  // Ini box putih yang punya shadow biar misah
                  _buildQuickMenuCard(),

                  const SizedBox(height: 20),

                  // --- BAGIAN KONTEN BAWAH (Payment List) ---
                  // Box putih besar di bawah untuk list menu lainnya
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
                        _buildPaymentList(),

                        // Promo Banner
                        _buildSpecialForYou(),

                        const SizedBox(
                          height: 80,
                        ), // Spacer bawah biar gak ketutup navbar
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

  // --- WIDGET HEADER (UPDATED) ---
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Baris Atas: Profile & Promo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Foto Profil dengan Stroke Putih
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

              // Chip Promo & Help
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

          // --- SALDO & POIN (UPDATED LAYOUT) ---
          Column(
            children: [
              // Baris Label Saldo & Chip Poin
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Total Balance",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10), // Jarak teks ke chip poin
                  // Chip Poin (Dipindah ke Kanan & Dikecilin)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background putih/kuning
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
                            fontSize: 10, // Ukuran font kecil
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              // Angka Saldo Besar
              const Text(
                "Rp 999.999.999",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- WIDGET QUICK MENU (BOX PUTIH MELAYANG) ---
  Widget _buildQuickMenuCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // Efek Shadow biar "melayang" dan misah dari box bawah
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Bayangan halus
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _menuItem(Icons.add_card_outlined, "Top Up", color: Colors.black87),
          _menuItem(
            Icons.send_to_mobile_outlined,
            "Transfer",
            color: Colors.black87,
          ),
          _menuItem(Icons.outbond_outlined, "Cash Out", color: Colors.black87),
          _menuItem(Icons.grid_view, "See All", color: Colors.black87),
        ],
      ),
    );
  }

  // --- WIDGET PAYMENT LIST ---
  Widget _buildPaymentList() {
    final List<Map<String, dynamic>> menuList = [
      {'icon': Icons.wifi, 'label': 'Credit/Data', 'color': Colors.red},
      {'icon': Icons.flash_on, 'label': 'Electricity', 'color': Colors.blue},
      {'icon': Icons.credit_card, 'label': 'E-Money', 'color': Colors.teal},
      {'icon': Icons.tv, 'label': 'Cable TV', 'color': Colors.orange},
      {'icon': Icons.wallet, 'label': 'E-Wallet', 'color': Colors.lightBlue},
      {'icon': Icons.mosque, 'label': 'Infaq', 'color': Colors.green},
      {'icon': Icons.gamepad, 'label': 'Games', 'color': Colors.amber},
      {'icon': Icons.more_horiz, 'label': 'More', 'color': Colors.grey},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Payment List",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: menuList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 25, // Jarak vertikal antar icon
              crossAxisSpacing: 10,
              childAspectRatio: 0.75, // Biar agak tinggi (muat teks 2 baris)
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  // Lingkaran Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: menuList[index]['color'].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      menuList[index]['icon'],
                      color: menuList[index]['color'],
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    menuList[index]['label'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // --- WIDGET PROMO BANNER ---
  Widget _buildSpecialForYou() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

  // Helper Widget buat Item Quick Menu (Icon doang + Text)
  Widget _menuItem(IconData icon, String label, {Color color = Colors.black}) {
    return Column(
      children: [
        // Icon di Quick Menu biasanya agak gede
        Icon(icon, color: const Color(0xFFED1C24), size: 32),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  // --- BOTTOM NAVBAR ---
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
