import 'package:flutter/material.dart';

class LatestUpdates extends StatelessWidget {
  const LatestUpdates({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> updates = [
      {
        'image': 'assets/images/dashboard/lates_updates/lates1.PNG',
        'title': 'Activate LinkAja! Syariah',
        'subtitle': 'Transactions #MakinBerkah',
      },
      {
        'image': 'assets/images/dashboard/lates_updates/lates2.PNG',
        'title': 'Cash Withdrawal',
        'subtitle': 'Easy and practical way',
      },
      {
        'image': 'assets/images/dashboard/lates_updates/lates3.PNG',
        'title': 'Investasi Emas',
        'subtitle': 'Mulai dari seribu rupiah',
      },
      {
        'image': 'assets/images/dashboard/lates_updates/lates4.PNG',
        'title': 'Bayar BPJS Kesehatan',
        'subtitle': 'Gak perlu antri lagi',
      },
      {
        'image': 'assets/images/dashboard/lates_updates/lates5.PNG',
        'title': 'Voucher Game Murah',
        'subtitle': 'Diskon setiap hari',
      },
    ];

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Latest Updates",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),

        // Scroll List
        SizedBox(
          height: 250, // TINGGI CONTAINER DITAMBAH
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: updates.length,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemBuilder: (context, index) {
              return Container(
                width: 360, // LEBAR KARTU DIPERBESAR
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
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.asset(
                        updates[index]['image']!,
                        height: 160, // TINGGI GAMBAR DISESUAIKAN
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => Container(
                          height: 160, 
                          color: Colors.grey[200], 
                          child: const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            updates[index]['title']!,
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
                            updates[index]['subtitle']!,
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