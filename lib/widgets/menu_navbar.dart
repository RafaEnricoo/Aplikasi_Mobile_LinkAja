import 'package:flutter/material.dart';

class MenuNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const MenuNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(), // Ini yang bikin efek 'coak' di tengah
      notchMargin: 8.0, // Jarak antara tombol merah dan navbar putih
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 70, // Sedikit lebih tinggi dari standar agar lega
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, 'Home', Icons.home_filled, 'home_icon.png'),
            _buildNavItem(1, 'History', Icons.description_outlined, 'history_icon.png'),
            
            const SizedBox(width: 48), // RUANG KOSONG UNTUK TOMBOL MERAH (FAB)
            
            _buildNavItem(2, 'Inbox', Icons.mail_outline, 'inbox_icon.png'),
            _buildNavItem(3, 'Account', Icons.person_outline, 'account_icon.png'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData iconData, String assetName) {
    // Logika warna: Jika index sama dengan selectedIndex, warna Merah.
    final bool isSelected = selectedIndex == index;
    final Color color = isSelected ? const Color(0xFFE52326) : Colors.grey;

    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Coba load gambar dari aset dulu
          SizedBox(
            width: 24,
            height: 24,
            child: Image.asset(
              'assets/images/dashboard/navbar/$assetName',
              color: color, // Fitur keren Flutter: bisa ganti warna gambar PNG/SVG
              errorBuilder: (context, error, stackTrace) {
                // Jika gambar tidak ketemu, pakai Icon bawaan
                return Icon(iconData, color: color, size: 26);
              },
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}