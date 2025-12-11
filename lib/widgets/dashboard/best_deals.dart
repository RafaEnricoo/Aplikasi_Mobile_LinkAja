import 'package:flutter/material.dart';

class BestDeals extends StatelessWidget {
  const BestDeals({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Dummy
    final List<Map<String, String>> deals = [
      {
        'image': 'assets/images/dashboard/best_deals/best1.PNG',
        'title': 'Payday Time!',
        'subtitle': 'Save up to IDR 200.000',
      },
      {
        'image': 'assets/images/dashboard/best_deals/best2.PNG',
        'title': 'Special 10.10 Deals',
        'subtitle': 'Only on LinkAja!',
      },
      {
        'image': 'assets/images/dashboard/best_deals/best3.PNG',
        'title': 'Cashback 10RB',
        'subtitle': 'Belanja Online & Pergi',
      },
      {
        'image': 'assets/images/dashboard/best_deals/best4.PNG',
        'title': 'Goro Investasi',
        'subtitle': 'Cairkan cuan properti',
      },
      {
        'image': 'assets/images/dashboard/best_deals/best5.PNG',
        'title': 'Promo Pulsa',
        'subtitle': 'Harga murah meriah',
      },
    ];

    return Column(
      children: [
        // 1. Header Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Best Deals",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                "See All",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFE52326), 
                ),
              ),
            ],
          ),
        ),

        // 2. Horizontal Scroll List
        SizedBox(
          height: 250, // TINGGI CONTAINER DITAMBAH (agar muat kartu yang lebih besar)
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: deals.length,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (context, index) {
              return Container(
                width: 360, // LEBAR KARTU DIPERBESAR (dari 260 ke 320)
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // A. Gambar
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.asset(
                        deals[index]['image']!,
                        height: 160, // TINGGI GAMBAR DISESUAIKAN (dari 140 ke 160)
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => Container(
                          height: 160, 
                          color: Colors.grey[200], 
                          child: const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                    
                    // B. Teks Judul & Subjudul
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deals[index]['title']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            deals[index]['subtitle']!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}