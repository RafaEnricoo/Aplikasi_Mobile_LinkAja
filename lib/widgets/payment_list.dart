import 'package:flutter/material.dart';

class PaymentList extends StatelessWidget {
  const PaymentList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuList = [
      {
        'image': 'assets/images/dashboard/payment_list/data.png',
        'label': 'Credit/Data',
        'color': Colors.red,
      },
      {
        'image': 'assets/images/dashboard/payment_list/lampu.png',
        'label': 'Electricity',
        'color': Colors.blue,
      },
      {
        'image': 'assets/images/dashboard/payment_list/money.png',
        'label': 'E-Money',
        'color': Colors.teal,
      },
      {
        'image': 'assets/images/dashboard/payment_list/tv.png',
        'label': 'Cable TV',
        'color': Colors.lightBlue,
      },
      {
        'image': 'assets/images/dashboard/payment_list/voucher.png',
        'label': 'E-Wallet',
        'color': Colors.lightBlue,
      },
      {
        'image': 'assets/images/dashboard/payment_list/infaq.png',
        'label': 'Infaq',
        'color': Colors.green,
      },
      {
        'image': 'assets/images/dashboard/payment_list/games.png',
        'label': 'Games',
        'color': Colors.amber,
      },
      {
        'image': 'assets/images/dashboard/payment_list/moree.png',
        'label': 'More',
        // PERBAIKAN 1: Ganti White jadi Grey.
        // Kalau white, bayangannya gak bakal kelihatan di background putih.
        'color': Colors.white,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Payment List",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: menuList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 25,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              Color baseColor = menuList[index]['color'];

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      // 1. STROKE / BINGKAI: Tetap Grey untuk semua tombol
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),

                      // 2. BACKGROUND & SHADOW
                      gradient: RadialGradient(
                        colors: [
                          // TENGAH: Warna asli (Merah/Biru) tapi soft (Opacity kecil)
                          // Ini biar "Background"-nya kerasa berwarna
                          baseColor.withOpacity(0.17),

                          // PINGGIR: Warna Grey (Shadow ke dalam)
                          // Ini yang bikin efek 'cekung' atau shadow abu-abu di pinggir
                          Colors.black.withOpacity(0.15),
                        ],
                        // Mengatur posisi percampuran warna
                        // 0.6 artinya warna aslinya dominan sampai 60% lingkaran
                        // baru sisanya transisi ke abu-abu
                        stops: const [0.75, 1.0],
                        center: Alignment.center,
                        radius: 0.9,
                      ),
                    ),
                    child: Image.asset(
                      menuList[index]['image'],
                      width: 36,
                      height: 36,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    menuList[index]['label'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
