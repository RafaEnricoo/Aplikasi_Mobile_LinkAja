import 'package:flutter/material.dart';

class PaymentList extends StatelessWidget {
  const PaymentList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuList = [
      {
        'image':
            'assets/images/dashboard/payment_list/data.png', // Ganti path sesuai file lu
        'label': 'Credit/Data',
        'color': Colors.red,
      },
      {
        'image': 'assets/images/dashboard/payment_list/icon_pln.png',
        'label': 'Electricity',
        'color': Colors.blue,
      },
      {
        'image': 'assets/images/dashboard/payment_list/icon_emoney.png',
        'label': 'E-Money',
        'color': Colors.teal,
      },
      {
        'image': 'assets/images/dashboard/payment_list/icon_tv.png',
        'label': 'Cable TV',
        'color': Colors.orange,
      },
      {
        'image': 'assets/images/dashboard/payment_list/icon_wallet.png',
        'label': 'E-Wallet',
        'color': Colors.lightBlue,
      },
      {
        'image': 'assets/images/dashboard/payment_list/icon_infaq.png',
        'label': 'Infaq',
        'color': Colors.green,
      },
      {
        'image': 'assets/images/dashboard/payment_list/mgames.png',
        'label': 'Games',
        'color': Colors.amber,
      },
      {
        'image': 'assets/images/dashboard/payment_list/more.png',
        'label': 'More',
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
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: menuList[index]['color'].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      menuList[index]['image'],
                      width: 28,
                      height: 28,
                      // color: menuList[index]['color'],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    menuList[index]['label'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
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
