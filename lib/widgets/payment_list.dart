import 'package:flutter/material.dart';

class PaymentList extends StatelessWidget {
  const PaymentList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuList = [
      {'icon': Icons.wifi, 'label': 'Credit/Data', 'color': Colors.red},
      {'icon': Icons.flash_on, 'label': 'Electricity', 'color': Colors.blue},
      {'icon': Icons.credit_card, 'label': 'E-Money', 'color': Colors.teal},
      {'icon': Icons.tv, 'label': 'Cable TV', 'color': Colors.orange},
      {'icon': Icons.wallet, 'label': 'E-Wallet', 'color': Colors.lightBlue},
      {'icon': Icons.mosque, 'label': 'Infaq', 'color': Colors.green},
      {'icon': Icons.gamepad, 'label': 'Games', 'color': Colors.amber},
      {'icon': Icons.more_horiz, 'label': 'More', 'color': Colors.grey},
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
                    child: Icon(
                      menuList[index]['icon'],
                      color: menuList[index]['color'],
                      size: 28,
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
