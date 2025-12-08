import 'package:flutter/material.dart';

class QuickMenu extends StatelessWidget {
  const QuickMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          _menuItem(Icons.add_card_outlined, "Top Up"),
          _menuItem(Icons.send_to_mobile_outlined, "Transfer"),
          _menuItem(Icons.outbond_outlined, "Cash Out"),
          _menuItem(Icons.grid_view, "See All"),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFED1C24), size: 32),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
