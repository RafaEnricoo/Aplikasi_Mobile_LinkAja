import 'package:flutter/material.dart';
import 'dart:async';

class PromoSlider extends StatefulWidget {
  const PromoSlider({super.key});

  @override
  State<PromoSlider> createState() => _PromoSliderState();
}

class _PromoSliderState extends State<PromoSlider> {
  late PageController _pageController;
  
  // --- KONFIGURASI BARU ---
  // viewportFraction 0.85 artinya gambar tengah makan 85% lebar layar.
  // Sisanya (15%) dibagi ke kiri dan kanan untuk "peeking".
  final double _viewportFraction = 0.85; 
  
  // Skala gambar samping. 0.8 artinya gambar samping ukurannya 80% dari gambar tengah.
  final double _sideScale = 0.8; 
  
  final double _height = 170.0;

  // ... (Variabel Timer & List gambar TETAP SAMA) ...
  int _currentPageIndex = 0;
  Timer? _timer;

  final List<String> promoImages = [
    'assets/images/dashboard/special_just_for_you/special1.png',
    'assets/images/dashboard/special_just_for_you/special2.png',
    'assets/images/dashboard/special_just_for_you/special3.png',
    'assets/images/dashboard/special_just_for_you/special4.png',
    'assets/images/dashboard/special_just_for_you/special5.png',
  ];

  @override
  void initState() {
    super.initState();
    // Gunakan variabel _viewportFraction yang baru
    _pageController = PageController(viewportFraction: _viewportFraction);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoPlay();
    });
  }

  // ... (Fungsi _startAutoPlay dan dispose TETAP SAMA, tidak diubah) ...
  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPageIndex < promoImages.length - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0; 
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPageIndex,
          duration: const Duration(milliseconds: 800), 
          curve: Curves.fastOutSlowIn, 
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            "Special Just For You!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),

        GestureDetector(
          onPanDown: (_) => _timer?.cancel(),
          onPanCancel: () => _startAutoPlay(),
          onPanEnd: (_) => _startAutoPlay(),
          child: SizedBox(
            height: 150, 
            child: PageView.builder(
              clipBehavior: Clip.none, 
              controller: _pageController,
              itemCount: promoImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double pagePosition = 0.0;
                    
                    if (_pageController.position.haveDimensions) {
                      pagePosition = _pageController.page!;
                    } else {
                      pagePosition = _currentPageIndex.toDouble();
                    }

                    // Menghitung selisih posisi
                    double difference = (index - pagePosition).abs();
                    
                    // --- LOGIKA SKALA YANG DIPERBAIKI ---
                    double scale;
                    
                    // Jika selisih < 1 (sedang transisi atau aktif)
                    if (difference < 1.0) {
                      // Rumus Interpolasi Linear:
                      // Saat difference 0 (tengah) -> scale = 1.0
                      // Saat difference 1 (samping) -> scale = _sideScale (0.8)
                      scale = 1 - (1 - _sideScale) * difference;
                    } else {
                      // Jika jauh dari tengah, paksa tetap kecil
                      scale = _sideScale;
                    }

                    // Matrix Transformasi
                    Matrix4 matrix = Matrix4.identity();
                    
                    // Terjemahan Vertikal (Biar gambar kecil tetap 'Center Vertical')
                    // Rumus: tinggi * (1 - scale) / 2
                    double verticalTranslation = 150 * (1 - scale) / 2;
                    
                    matrix = Matrix4.diagonal3Values(1, scale, 1)
                      ..setTranslationRaw(0, verticalTranslation, 0);

                    return Transform(
                      transform: matrix,
                      alignment: Alignment.center,
                      child: child,
                    );
                  },
                  // Child tetap sama
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12), // Padding dikecilkan dikit
                    child: Align(
                      alignment: Alignment.center, 
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            promoImages[index],
                            fit: BoxFit.fill, // Ganti ke FILL atau COVER biar penuh
                            width: double.infinity, // Paksa lebar penuh container
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        
        const SizedBox(height: 20),

        // Indikator Dots (TETAP SAMA)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: promoImages.asMap().entries.map((entry) {
            bool isActive = _currentPageIndex == entry.key;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              width: isActive ? 24.0 : 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isActive ? const Color(0xFFE52326) : Colors.grey[300],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}