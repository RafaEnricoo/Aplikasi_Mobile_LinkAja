import 'package:flutter/material.dart';
import 'dart:math' as math;

class MenuNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  // Warna referensi
  static const Color brandRedDeep = Color(0xFFE52326);
  static const Color brandRedLight = Color(0xFFFFBABA);
  static const Color inactiveGrey = Colors.grey;
  
  // Warna Border (Abu keputihan halus)
  static const Color borderColor = Color.fromARGB(255, 227, 227, 227); // atau Colors.grey[200]

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
      elevation: 0, // Elevation dimatikan di sini, kita handle shadow via Parent atau biarkan flat
      // Jika ingin shadow, sebaiknya wrap BottomAppBar di Container dengan BoxShadow, 
      // tapi karena bentuknya notched, shadow bawaan elevation 15 sudah cukup.
      // Kita kembalikan elevation ke 15 sesuai request sebelumnya:
      shadowColor: Colors.black26,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: CustomPaint(
        // PANGGIL PAINTER DISINI
        // Painter ini akan menggambar garis di atas navbar mengikuti cekungan
        painter: NavbarBorderPainter(
          color: borderColor,
          width: 1.5,   // Ketebalan garis
          smoothness: 8, // Harus sama dengan SmoothNotchedRectangle
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
                child: _buildNavItem(2, 'Inbox', Icons.mail_outline, Icons.mail),
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

  Widget _buildNavItem(int index, String label, IconData outlineIcon, IconData filledIcon) {
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
            SizedBox(height: 28, child: iconWidget),
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

// --------------------------------------------------------------------------
// 2. PAINTER KHUSUS UNTUK GARIS BORDER
// --------------------------------------------------------------------------
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

    // -- LOGIKA MATEMATIKA YANG SAMA DENGAN SmoothNotchedRectangle --
    // Kita asumsikan FAB ada di tengah (size.width / 2)
    // dan posisinya centerDocked (y = 0 relative terhadap navbar)
    
    // Estimasi lebar FAB + Margin (disesuaikan agar pas dengan bolongan)
    // Standard FAB = 56, Custom FAB Anda = 65.
    // Margin SmoothNotchedRectangle = 8.
    // Jadi total guest width kira-kira 65. Kita pakai angka aman agar garisnya pas.
    const double guestWidth = 65.0; // Sesuaikan ini jika garis kurang lebar/sempit
    const double margin = 8.0;
    
    final double notchRadius = guestWidth / 2.0 + margin;
    
    final double s1 = smoothness;
    final double s2 = smoothness;
    final double r = notchRadius;
    final double a = -1.0 * r - s2;
    final double b = 0.0; // host.top (0) - guest.center.dy (0)

    final double n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final double p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final double p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final double p2yA = math.sqrt(r * r - p2xA * p2xA) - b;
    final double p2yB = math.sqrt(r * r - p2xB * p2xB) - b;

    final List<Offset?> p = List.filled(6, null);

    // Titik pusat X adalah tengah layar
    final double centerX = size.width / 2;

    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    
    final double cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    p[3] = Offset(-1.0 * p[2]!.dx, p[2]!.dy);
    p[4] = Offset(-1.0 * p[1]!.dx, p[1]!.dy);
    p[5] = Offset(-1.0 * p[0]!.dx, p[0]!.dy);

    // Geser semua titik ke tengah layar
    for (int i = 0; i < p.length; i += 1) {
      p[i] = p[i]! + Offset(centerX, 0);
    }

    // -- MENGGAMBAR JALUR GARIS --
    // 1. Garis dari Kiri Mentok sampai awal lengkungan
    path.moveTo(0, 0);
    path.lineTo(p[0]!.dx, p[0]!.dy);

    // 2. Kurva Masuk
    path.quadraticBezierTo(p[1]!.dx, p[1]!.dy, p[2]!.dx, p[2]!.dy);

    // 3. Lengkungan Bawah (Mangkok)
    path.arcToPoint(
      p[3]!,
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // 4. Kurva Keluar
    path.quadraticBezierTo(p[4]!.dx, p[4]!.dy, p[5]!.dx, p[5]!.dy);

    // 5. Garis dari akhir lengkungan sampai Kanan Mentok
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// --------------------------------------------------------------------------
// 3. SMOOTH NOTCHED RECTANGLE (Bawaan Anda, Tetap Sama)
// --------------------------------------------------------------------------
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