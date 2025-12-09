import 'package:flutter/material.dart';
import 'dart:async';

class PromoSlider extends StatefulWidget {
  const PromoSlider({super.key});

  @override
  State<PromoSlider> createState() => _PromoSliderState();
}

class _PromoSliderState extends State<PromoSlider> {
  late PageController _pageController;
  
  // Konfigurasi Skala
  final double _scaleFactor = 0.85; 
  final double _height = 170.0;

  // Variabel Auto Play
  int _currentPageIndex = 0;
  Timer? _timer;

  final List<String> promoImages = [
    'assets/images/dashboard/special_just_for_you/special1.PNG',
    'assets/images/dashboard/special_just_for_you/special2.PNG',
    'assets/images/dashboard/special_just_for_you/special3.PNG',
    'assets/images/dashboard/special_just_for_you/special4.PNG',
    'assets/images/dashboard/special_just_for_you/special5.PNG',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
    
    // TIDAK PERLU addListener setState LAGI DISINI (Bikin Lag)

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoPlay();
    });
  }

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
            height: 200, 
            child: PageView.builder(
              clipBehavior: Clip.none, 
              controller: _pageController,
              itemCount: promoImages.length,
              onPageChanged: (index) {
                // setState hanya untuk update titik indikator (ringan)
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                // --- PERUBAHAN UTAMA DISINI ---
                // Gunakan AnimatedBuilder untuk animasi super halus
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double pagePosition = 0.0;
                    
                    // Ambil posisi pixel akurat saat ini
                    if (_pageController.position.haveDimensions) {
                      pagePosition = _pageController.page!;
                    } else {
                      // Fallback saat pertama kali render
                      pagePosition = _currentPageIndex.toDouble();
                    }

                    // Rumus Matematika Simple & Simetris:
                    // Hitung jarak index gambar ini dari posisi scroll saat ini
                    // Hasilnya: 0.0 (Tepat di tengah), 1.0 (Sebelahnya), dst.
                    double difference = (index - pagePosition).abs();
                    
                    // Batasi kalkulasi hanya untuk gambar yang terlihat (jarak < 1)
                    double scale = _scaleFactor;
                    if (difference < 1.0) {
                      // Interpolasi dari 0.85 ke 1.0 berdasarkan kedekatan ke tengah
                      scale = 1 - (1 - _scaleFactor) * difference;
                    }

                    // Hitung Matrix Transformasi
                    Matrix4 matrix = Matrix4.identity();
                    double verticalTranslation = _height * (1 - scale) / 2;
                    matrix = Matrix4.diagonal3Values(1, scale, 1)
                      ..setTranslationRaw(0, verticalTranslation, 0);

                    return Transform(
                      transform: matrix,
                      alignment: Alignment.center,
                      child: child, // Child adalah Container gambar di bawah
                    );
                  },
                  // Child statis (Gambar) yang tidak perlu direbuild terus-menerus
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12), // Jarak antar gambar
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage(promoImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        promoImages[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Indikator Dots
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