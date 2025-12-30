import 'package:flutter/material.dart';
import 'dart:math' as math;

class MenuNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  // Warna referensi
  static const Color brandRedDeep = Color(0xFFE52326);
  static const Color brandRedLight = Color(0xFFFFBABA);
  static const Color inactiveGrey = Colors.grey;
  
  // Warna Border
  static const Color borderColor = Color.fromARGB(255, 227, 227, 227);

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
      elevation: 0,
      shadowColor: Colors.black26,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: CustomPaint(
        painter: NavbarBorderPainter(
          color: borderColor,
          width: 1.5,
          smoothness: 8,
        ),
        child: SizedBox(
          height: 65,
          child: Row(
            children: [
              // KIRI
              Expanded(
                child: _buildNavItem(0, 'Home', Icons.home_outlined, Icons.home),
              ),
              Expanded(
                child: _buildNavItem(1, 'History', Icons.assignment_outlined, Icons.assignment),
              ),

              // TENGAH (SPACER QR)
              const SizedBox(width: 60),

              // KANAN
              Expanded(
                // CONTOH: Memberikan titik merah pada Inbox
                child: _buildNavItem(2, 'Inbox', Icons.mail_outline, Icons.mail, showRedDot: true),
              ),
              Expanded(
                child: _buildNavItem(3, 'Account', Icons.person_outline, Icons.person),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- UPDATE DI SINI: Tambah parameter showRedDot ---
  Widget _buildNavItem(int index, String label, IconData outlineIcon, IconData filledIcon, {bool showRedDot = false}) {
    final bool isSelected = selectedIndex == index;
    Widget iconWidget;

    if (isSelected) {
      iconWidget = ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [brandRedLight, brandRedDeep],
            stops: [0.0, 0.8], 
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcATop,
        child: Icon(filledIcon, size: 28, color: Colors.white),
      );
    } else {
      iconWidget = Icon(outlineIcon, size: 28, color: inactiveGrey);
    }

    return InkWell(
      onTap: () => onTap(index),
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
            // --- UPDATE DI SINI: Bungkus icon dengan Stack ---
            SizedBox(
              height: 28, // Tinggi area icon tetap
              width: 32,  // Lebar sedikit ditambah agar titik merah tidak terpotong
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none, // Izinkan titik keluar area jika perlu
                children: [
                  iconWidget, // Icon Utama
                  
                  // Titik Merah (Badge)
                  if (showRedDot)
                    Positioned(
                      right: 2, // Posisi Kanan
                      top: 2,   // Posisi Atas
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: brandRedDeep, // Warna Merah Brand
                          shape: BoxShape.circle,
                          // Border putih agar icon dan titik merah tidak menyatu
                          border: Border.all(color: Colors.white, width: 1.8), 
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: 4),
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

// ... (Class NavbarBorderPainter dan SmoothNotchedRectangle tetap sama seperti sebelumnya) ...
class NavbarBorderPainter extends CustomPainter {
  final Color color;
  final double width;
  final double smoothness;

  NavbarBorderPainter({
    required this.color,
    required this.width,
    required this.smoothness,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final Path path = Path();
    const double guestWidth = 65.0; 
    const double margin = 8.0;
    
    final double notchRadius = guestWidth / 2.0 + margin;
    
    final double s1 = smoothness;
    final double s2 = smoothness;
    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = 0.0; 

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA) - b;
    final double p2yB = math.sqrt(r * r - p2xB * p2xB) - b;

    final List<Offset?> p = List.filled(6, null);
    final double centerX = size.width / 2;

    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    p[3] = Offset(-1.0 * p[2]!.dx, p[2]!.dy);
    p[4] = Offset(-1.0 * p[1]!.dx, p[1]!.dy);
    p[5] = Offset(-1.0 * p[0]!.dx, p[0]!.dy);

    for (int i = 0; i < p.length; i += 1) {
      p[i] = p[i]! + Offset(centerX, 0);
    }

    path.moveTo(0, 0);
    path.lineTo(p[0]!.dx, p[0]!.dy);
    path.quadraticBezierTo(p[1]!.dx, p[1]!.dy, p[2]!.dx, p[2]!.dy);
    path.arcToPoint(
      p[3]!,
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.quadraticBezierTo(p[4]!.dx, p[4]!.dy, p[5]!.dx, p[5]!.dy);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SmoothNotchedRectangle extends NotchedShape {
  final double smoothness; 
  const SmoothNotchedRectangle({this.smoothness = 12.0});

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    const double margin = 8.0; 
    final double notchRadius = guest.width / 2.0 + margin;
    
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

    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    p[3] = Offset(-1.0 * p[2]!.dx, p[2]!.dy);
    p[4] = Offset(-1.0 * p[1]!.dx, p[1]!.dy);
    p[5] = Offset(-1.0 * p[0]!.dx, p[0]!.dy);

    for (int i = 0; i < p.length; i += 1) {
      p[i] = p[i]! + guest.center;
    }

    return Path()
      ..moveTo(host.left, host.top)
      ..lineTo(p[0]!.dx, p[0]!.dy)
      ..quadraticBezierTo(p[1]!.dx, p[1]!.dy, p[2]!.dx, p[2]!.dy)
      ..arcToPoint(p[3]!, radius: Radius.circular(notchRadius), clockwise: false)
      ..quadraticBezierTo(p[4]!.dx, p[4]!.dy, p[5]!.dx, p[5]!.dy)
      ..lineTo(host.right, host.top)
      ..lineTo(host.right, host.bottom)
      ..lineTo(host.left, host.bottom)
      ..close();
  }
}