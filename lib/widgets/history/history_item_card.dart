import 'package:flutter/material.dart';
import '../../models/transaction_model.dart';

class HistoryItemCard extends StatelessWidget {
  final TransactionModel transaction;

  const HistoryItemCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    // Helper buat nentuin warna status teks
    Color getStatusColor(String status) {
      switch (status.toLowerCase()) {
        case 'success':
          return Colors.green;
        case 'pending':
          return Colors.orange;
        case 'failed':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    // Helper logika ukuran icon
    // Kalau judulnya 'Top Up', kecilin jadi 20. Selain itu 28.
    double getIconSize() {
      return transaction.title == 'Top Up' ? 20.0 : 28.0;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
      ),
      child: Row(
        children: [
          // 1. LOGO ICON (Kiri)
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white, // Background Putih Bersih
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200), // Border tipis
            ),
            child: Center(
              // Logika Gambar
              child:
                  (transaction.iconAsset != null &&
                      transaction.iconAsset!.isNotEmpty)
                  ? Image.asset(
                      transaction.iconAsset!,
                      width: getIconSize(), // Ukuran dinamis
                      height: getIconSize(), // Ukuran dinamis
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.receipt_long,
                          color: Colors.red.shade700,
                        );
                      },
                    )
                  : Icon(Icons.receipt_long, color: Colors.red.shade700),
            ),
          ),

          const SizedBox(width: 15),

          // 2. JUDUL & TANGGAL (Tengah)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.date,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),

          // 3. HARGA & STATUS (Kanan)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                // Tambah tanda minus kalau PENGELUARAN (bukan income)
                '${transaction.isIncome ? "" : "- "}${transaction.amount}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                transaction.status,
                style: TextStyle(
                  color: getStatusColor(transaction.status),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
