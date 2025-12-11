import 'package:flutter/material.dart';
import 'dart:async';
import 'login.dart'; // Pastikan file ini ada

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isHovering = false;
  Timer? _timer;

  // Warna Merah Vivid
  final Color brandRed = const Color(0xFFFF1F1F);
  final Color greyText = const Color(0xFF7A7A7A);

  final List<Map<String, String>> _slides = [
    {
      'image': 'assets/images/landing_page/illustration1.png',
      'title': 'Pay and Send Money Instantly',
      'subtitle': 'Manage all your financial needs in\none app.',
    },
    {
      'image': 'assets/images/landing_page/illustration2.png',
      'title': 'Your Transactions Are Always Safe',
      'subtitle': 'Protected with PIN, biometrics, and\nmulti-layer security.',
    },
    {
      'image': 'assets/images/landing_page/illustration3.png',
      'title': 'Do More, Earn More',
      'subtitle':
          'Pay bills, buy data, and enjoy\nexclusive cashback every day.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _slides.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 1. LOGO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Image.asset(
                'assets/images/landing_page/logo.png',
                height: 80,
                errorBuilder: (ctx, err, stack) => Icon(
                  Icons.account_balance_wallet,
                  size: 50,
                  color: brandRed,
                ),
              ),
            ),

            // 2. SLIDER GAMBAR
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildSlideItem(
                    image: _slides[index]['image']!,
                    title: _slides[index]['title']!,
                    subtitle: _slides[index]['subtitle']!,
                  );
                },
              ),
            ),

            // --- JARAK ANTARA SLIDER DAN INDIKATOR ---
            const SizedBox(height: 40),

            // 3. INDIKATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (index) => _buildIndicatorDot(index),
              ),
            ),

            // 4. JARAK PEMISAH
            const SizedBox(height: 120),

            // 5. TOMBOL "Get Started"
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 40.0,
              ),
              child: MouseRegion(
                onEnter: (_) => setState(() => _isHovering = true),
                onExit: (_) => setState(() => _isHovering = false),
                child: GestureDetector(
                  onTap: () {
                    _timer?.cancel();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: _isHovering
                            ? [const Color(0xFFFF6B6B), const Color(0xFFFF3333)]
                            : [
                                const Color(0xFFFF4545),
                                const Color(0xFFE52326),
                              ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD32F2F).withOpacity(0.4),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    // --- PERBAIKAN DI SINI ---
                    // Menggunakan Border.all agar uniform dan tidak crash
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildSlideItem({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          // SPACER ATAS
          const Spacer(),

          // FIXED HEIGHT GAMBAR
          SizedBox(
            height: 280,
            width: double.infinity,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
              errorBuilder: (ctx, err, stack) => Container(
                color: Colors.grey[200],
                child: const Icon(
                  Icons.image_not_supported,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // FIXED HEIGHT TEKS
          SizedBox(
            height: 110,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 14),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: greyText, height: 1.5),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorDot(int index) {
    bool isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24.0 : 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: isActive ? brandRed : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
