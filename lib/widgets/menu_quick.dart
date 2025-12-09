import 'package:flutter/material.dart';

class QuickMenu extends StatelessWidget {
  const QuickMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 45),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _menuItem('assets/images/dashboard/quick_menu/topup.png', "Top up"),
          _menuItem('assets/images/dashboard/quick_menu/kirim.png', "Transfer"),
          _menuItem('assets/images/dashboard/quick_menu/cashout.png', "Cash Out"),
          _menuItem('assets/images/dashboard/quick_menu/seeall.png', "See All"),
        ],
      ),
    );
  }

  Widget _menuItem(String assetPath, String label) {
    return Column(
      children: [
        // Pakai Image.asset karena datanya sekarang Path Gambar
        Image.asset(assetPath, width: 32, height: 32),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
