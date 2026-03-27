// lib/screens/history_screen.dart
import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../widgets/history/history_header.dart';
import '../widgets/history/history_item_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // --- DATA SEPTEMBER 2025 ---
  final List<TransactionModel> transactionsSept = [
    TransactionModel(
      title: 'Mobile Legends Purchase',
      date: '28 Sep 2025 • 20:15',
      amount: 'IDR 150.000',
      status: 'Success',
      iconAsset: 'assets/images/history/ml.png',
    ),
    TransactionModel(
      title: 'Pulsa Purchase',
      date: '25 Sep 2025 • 09:30',
      amount: 'IDR 50.000',
      status: 'Success',
      iconAsset: 'assets/images/history/Logo_IM3.png',
    ),
    TransactionModel(
      title: 'Valorant Purchase',
      date: '18 Sep 2025 • 14:20',
      amount: 'IDR 100.000',
      status: 'Pending',
      iconAsset: 'assets/images/history/valorant.png',
    ),
    TransactionModel(
      title: 'Top Up',
      date: '15 Sep 2025 • 08:00',
      amount: 'IDR 500.000',
      status: 'Success',
      iconAsset: 'assets/images/history/topup.png',
      isIncome: true,
    ),
    TransactionModel(
      title: 'Mobile Legends Purchase',
      date: '10 Sep 2025 • 19:45',
      amount: 'IDR 50.000',
      status: 'Success',
      iconAsset: 'assets/images/history/ml.png',
    ),
    TransactionModel(
      title: 'Top Up',
      date: '02 Sep 2025 • 11:10',
      amount: 'IDR 200.000',
      status: 'Success',
      iconAsset: 'assets/images/history/topup.png',
      isIncome: true,
    ),
  ];

  // --- DATA AGUSTUS 2025 ---
  final List<TransactionModel> transactionsAug = [
    TransactionModel(
      title: 'Valorant Purchase',
      date: '28 Aug 2025 • 20:15',
      amount: 'IDR 100.000',
      status: 'Success',
      iconAsset: 'assets/images/history/valorant.png',
    ),
    TransactionModel(
      title: 'Mobile Legends Purchase',
      date: '22 Aug 2025 • 16:30',
      amount: 'IDR 300.000',
      status: 'Success',
      iconAsset: 'assets/images/history/ml.png',
    ),
    TransactionModel(
      title: 'Pulsa Purchase',
      date: '15 Aug 2025 • 10:00',
      amount: 'IDR 25.000',
      status: 'Failed',
      iconAsset: 'assets/images/history/Logo_IM3.png',
    ),
    TransactionModel(
      title: 'Top Up',
      date: '10 Aug 2025 • 09:00',
      amount: 'IDR 1.000.000',
      status: 'Success',
      iconAsset: 'assets/images/history/topup.png',
      isIncome: true,
    ),
    TransactionModel(
      title: 'Mobile Legends Purchase',
      date: '05 Aug 2025 • 21:00',
      amount: 'IDR 75.000',
      status: 'Success',
      iconAsset: 'assets/images/history/ml.png',
    ),
    TransactionModel(
      title: 'Top Up',
      date: '01 Aug 2025 • 07:00',
      amount: 'IDR 200.000',
      status: 'Success',
      iconAsset: 'assets/images/history/topup.png',
      isIncome: true,
    ),
  ];

  // --- DATA JULI 2025 ---
  final List<TransactionModel> transactionsJuly = [
    TransactionModel(
      title: 'Mobile Legends Purchase',
      date: '25 Jul 2025 • 19:30',
      amount: 'IDR 150.000',
      status: 'Success',
      iconAsset: 'assets/images/history/ml.png',
    ),
    TransactionModel(
      title: 'Top Up',
      date: '20 Jul 2025 • 18:30',
      amount: 'IDR 1.000.000',
      status: 'Success',
      iconAsset: 'assets/images/history/topup.png',
      isIncome: true,
    ),
    TransactionModel(
      title: 'Pulsa Purchase',
      date: '15 Jul 2025 • 08:15',
      amount: 'IDR 100.000',
      status: 'Success',
      iconAsset: 'assets/images/history/Logo_IM3.png',
    ),
    TransactionModel(
      title: 'Valorant Purchase',
      date: '05 Jul 2025 • 12:45',
      amount: 'IDR 300.000',
      status: 'Success',
      iconAsset: 'assets/images/history/valorant.png',
    ),
    TransactionModel(
      title: 'Mobile Legends Purchase',
      date: '01 Jul 2025 • 20:00',
      amount: 'IDR 50.000',
      status: 'Failed',
      iconAsset: 'assets/images/history/ml.png',
    ),
  ];

  // --- DATA JUNI 2025 ---
  final List<TransactionModel> transactionsJune = [
    TransactionModel(
      title: 'Pulsa Purchase',
      date: '30 Jun 2025 • 21:00',
      amount: 'IDR 50.000',
      status: 'Success',
      iconAsset: 'assets/images/history/Logo_IM3.png',
    ),
    TransactionModel(
      title: 'Top Up',
      date: '25 Jun 2025 • 10:00',
      amount: 'IDR 500.000',
      status: 'Success',
      iconAsset: 'assets/images/history/topup.png',
      isIncome: true,
    ),
    TransactionModel(
      title: 'Mobile Legends Purchase',
      date: '18 Jun 2025 • 19:45',
      amount: 'IDR 150.000',
      status: 'Success',
      iconAsset: 'assets/images/history/ml.png',
    ),
    TransactionModel(
      title: 'Valorant Purchase',
      date: '12 Jun 2025 • 15:10',
      amount: 'IDR 100.000',
      status: 'Failed',
      iconAsset: 'assets/images/history/valorant.png',
    ),
    TransactionModel(
      title: 'Top Up',
      date: '02 Jun 2025 • 09:30',
      amount: 'IDR 150.000',
      status: 'Success',
      iconAsset: 'assets/images/history/topup.png',
      isIncome: true,
    ),
  ];

  // --- DATA MEI 2025 ---
  final List<TransactionModel> transactionsMay = [
    TransactionModel(
      title: 'Mobile Legends Purchase',
      date: '28 May 2025 • 22:00',
      amount: 'IDR 300.000',
      status: 'Success',
      iconAsset: 'assets/images/history/ml.png',
    ),
    TransactionModel(
      title: 'Valorant Purchase',
      date: '20 May 2025 • 16:20',
      amount: 'IDR 150.000',
      status: 'Success',
      iconAsset: 'assets/images/history/valorant.png',
    ),
    TransactionModel(
      title: 'Top Up',
      date: '15 May 2025 • 08:45',
      amount: 'IDR 800.000',
      status: 'Success',
      iconAsset: 'assets/images/history/topup.png',
      isIncome: true,
    ),
    TransactionModel(
      title: 'Pulsa Purchase',
      date: '05 May 2025 • 11:11',
      amount: 'IDR 50.000',
      status: 'Success',
      iconAsset: 'assets/images/history/Logo_IM3.png',
    ),
  ];

  // --- DATA APRIL 2025 ---
  final List<TransactionModel> transactionsApr = [
    TransactionModel(
      title: 'Top Up',
      date: '28 Apr 2025 • 07:30',
      amount: 'IDR 500.000',
      status: 'Success',
      iconAsset: 'assets/images/history/topup.png',
      isIncome: true,
    ),
    TransactionModel(
      title: 'Mobile Legends Purchase',
      date: '15 Apr 2025 • 19:15',
      amount: 'IDR 75.000',
      status: 'Success',
      iconAsset: 'assets/images/history/ml.png',
    ),
    TransactionModel(
      title: 'Valorant Purchase',
      date: '02 Apr 2025 • 14:00',
      amount: 'IDR 200.000',
      status: 'Success',
      iconAsset: 'assets/images/history/valorant.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. Header
          const HistoryHeader(),

          const SizedBox(height: 10),

          // 2. List Transaksi
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // BULAN SEPTEMBER
                _buildSectionTitle('September 2025'),
                ...transactionsSept.map(
                  (data) => HistoryItemCard(transaction: data),
                ),
                const SizedBox(height: 10),

                // BULAN AGUSTUS
                _buildSectionTitle('Agustus 2025'),
                ...transactionsAug.map(
                  (data) => HistoryItemCard(transaction: data),
                ),
                const SizedBox(height: 10),

                // BULAN JULI
                _buildSectionTitle('Juli 2025'),
                ...transactionsJuly.map(
                  (data) => HistoryItemCard(transaction: data),
                ),
                const SizedBox(height: 10),

                // BULAN JUNI
                _buildSectionTitle('Juni 2025'),
                ...transactionsJune.map(
                  (data) => HistoryItemCard(transaction: data),
                ),
                const SizedBox(height: 10),

                // BULAN MEI
                _buildSectionTitle('Mei 2025'),
                ...transactionsMay.map(
                  (data) => HistoryItemCard(transaction: data),
                ),
                const SizedBox(height: 10),

                // BULAN APRIL
                _buildSectionTitle('April 2025'),
                ...transactionsApr.map(
                  (data) => HistoryItemCard(transaction: data),
                ),

                // Space bawah agar tidak ketutup navbar
                const SizedBox(height: 120),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        // Ini garis bawahnya bub
        const Divider(thickness: 1, height: 1, color: Color(0xFFEEEEEE)),
      ],
    );
  }
}