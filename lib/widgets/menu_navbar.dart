import 'package:flutter/material.dart';
import 'dart:math' as math;

class MenuNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  // Definisi warna sesuai referensi gambar
  static const Color brandRedDeep = Color(0xFFE52326);   // Merah bawah
  static const Color brandRedLight = Color(0xFFFFBABA);  // Merah muda/putih atas
  static const Color inactiveGrey = Colors.grey;
  
  const MenuNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const SmoothNotchedRectangle(smoothness: 8),
      notchMargin: 0,
      elevation: 15, // Bayangan agak tebal biar terlihat misah
      shadowColor: Colors.black26,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 65,
        child: Row(
          children: [
            // KIRI
            Expanded(
              // Gunakan pasangan icon Outline dan Filled
              child: _buildNavItem(0, 'Home', Icons.home_outlined, Icons.home),
            ),
            Expanded(
              // Icon history yang lebih mirip di gambar adalah receipt_long
              child: _buildNavItem(1, 'History', Icons.assignment_outlined, Icons.assignment),
            ),

            // TENGAH (SPACER QR)
            const SizedBox(width: 60),

            // KANAN
            Expanded(
              child: _buildNavItem(2, 'Inbox', Icons.mail_outline, Icons.mail),
            ),
            Expanded(
              child: _buildNavItem(3, 'Account', Icons.person_outline, Icons.person),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi builder sekarang menerima 2 icon: versi outline dan versi filled
  Widget _buildNavItem(int index, String label, IconData outlineIcon, IconData filledIcon) {
    final bool isSelected = selectedIndex == index;

    Widget iconWidget;

    if (isSelected) {
      // --- STATE AKTIF: Icon FILLED + GRADASI ---
      iconWidget = ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              brandRedLight, // Atas: Merah terang keputihan
              brandRedDeep,  // Bawah: Merah pekat
            ],
            // Gradasi halus dari atas ke bawah
            stops: [0.0, 0.8], 
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcATop,
        // PENTING: Gunakan icon versi FILLED (berisi)
        // Beri warna dasar putih agar bisa "disemprot" warna gradasi
        child: Icon(filledIcon, size: 28, color: Colors.white),
      );
    } else {
      // --- STATE INAKTIF: Icon OUTLINE + ABU ---
      // Gunakan icon versi OUTLINE
      iconWidget = Icon(outlineIcon, size: 28, color: inactiveGrey);
    }

    return InkWell(
      onTap: () => onTap(index),
      // Matikan efek hover/splash abu-abu agar bersih
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Widget Icon yang sudah di-handle logikanya di atas
            SizedBox(
              height: 28,
              child: iconWidget, 
            ),
            const SizedBox(height: 4),
            // Label Teks (Solid Red saat aktif, tidak gradasi)
            Text(
              label,
              style: TextStyle(
                color: isSelected ? brandRedDeep : inactiveGrey,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmoothNotchedRectangle extends NotchedShape {
  // Mengatur seberapa halus lengkungannya (0 = kaku, 20 = sangat landai)
  final double smoothness; 

  const SmoothNotchedRectangle({this.smoothness = 12.0});

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    // Margin tambahan biar lubangnya agak longgar dari tombol
    const double margin = 8.0; 
    
    final double notchRadius = guest.width / 2.0 + margin;
    
    // Titik pusat lingkaran tombol
    final double s1 = smoothness;
    final double s2 = smoothness;

    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = host.top - guest.center.dy;

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA) - b;
    final double p2yB = math.sqrt(r * r - p2xB * p2xB) - b;

    final List<Offset?> p = List.filled(6, null);

    // Menentukan titik koordinat bezier curve
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    p[3] = Offset(-1.0 * p[2]!.dx, p[2]!.dy);
    p[4] = Offset(-1.0 * p[1]!.dx, p[1]!.dy);
    p[5] = Offset(-1.0 * p[0]!.dx, p[0]!.dy);

    // Menggambar jalur (Path)
    for (int i = 0; i < p.length; i += 1) {
      p[i] = p[i]! + guest.center;
    }

    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(p[0]!.dx, p[0]!.dy)
      // Kurva masuk (halus)
      ..quadraticBezierTo(p[1]!.dx, p[1]!.dy, p[2]!.dx, p[2]!.dy)
      // Lingkaran bawah (mangkok)
      ..arcToPoint(
        p[3]!,
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      // Kurva keluar (halus)
      ..quadraticBezierTo(p[4]!.dx, p[4]!.dy, p[5]!.dx, p[5]!.dy)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}