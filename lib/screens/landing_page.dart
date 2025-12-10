import 'package:flutter/material.dart';
import 'dart:async'; // 1. IMPORT INI WAJIB (untuk Timer)
import 'login.dart'; 

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  bool _isHovering = false;

  // 2. VARIABEL TIMER
  Timer? _timer; 

  final Color brandRed = Colors.red;
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
      'subtitle': 'Pay bills, buy data, and enjoy\nexclusive cashback every day.',
    },
  ];

  // 3. INIT STATE: Jalankan Timer saat halaman dibuka
  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  // 4. FUNGSI LOGIKA AUTO SCROLL
  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _slides.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Balik ke halaman pertama jika sudah mentok
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350), // Kecepatan geser
          curve: Curves.easeIn, // Efek animasi
        );
      }
    });
  }

  // 5. DISPOSE: Matikan Timer saat keluar halaman (PENTING biar gak memori leak)
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
            
            // LOGO
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Image.asset(
                'assets/images/landing_page/logo.png', 
                height: 80,
                errorBuilder: (ctx, err, stack) => Icon(
                  Icons.account_balance_wallet, 
                  size: 50, 
                  color: brandRed
                ),
              ),
            ),

            // SLIDER
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

            // BOTTOM SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
              child: Column(
                children: [
                  // INDIKATOR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (index) => _buildIndicatorDot(index),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // B. TOMBOL "Get Started" (REVISI: LEBIH TERANG & TEXT FIX)
                  MouseRegion(
                    onEnter: (_) => setState(() => _isHovering = true),
                    onExit: (_) => setState(() => _isHovering = false),
                    
                    child: GestureDetector(
                      onTap: () {
                        _timer?.cancel(); 
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          
                          // 1. REVISI WARNA: MERAH LEBIH TERANG (VIVID)
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: _isHovering 
                              // Saat Hover: Merah agak Orange dikit biar nyala
                              ? [const Color(0xFFFF6B6B), const Color(0xFFFF3333)] 
                              // Normal: Merah Terang (Vivid) ke Merah LinkAja Standard
                              : [const Color(0xFFFF4545), const Color(0xFFE52326)], 
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 102, 20, 20).withOpacity(0.4), // Shadow merah gelap (bukan hitam pekat)
                              offset: const Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ],

                          border: Border(
                            top: BorderSide(color: Colors.white.withOpacity(0.5), width: 1.5),
                            right: BorderSide(color: Colors.white.withOpacity(0.3), width: 1.0),
                            left: BorderSide.none,
                            bottom: BorderSide(color: Colors.black.withOpacity(0.05), width: 1.0),
                          ),
                        ),
                        
                        // --- BAGIAN INI PENTING AGAR TEKS MUNCUL ---
                        // Pastikan 'child' ini ada DI DALAM AnimatedContainer, bukan di luarnya
                        child: const Center(
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Warna teks putih
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        // -------------------------------------------
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlideItem({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              errorBuilder: (ctx, err, stack) => Container(
                height: 250, width: 250, color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: greyText,
              height: 1.5,
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