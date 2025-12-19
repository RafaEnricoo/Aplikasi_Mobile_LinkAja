// lib/models/transaction_model.dart

class TransactionModel {
  final String title;
  final String date;
  final String amount;
  final String status;
  final String? iconAsset; // Pastikan ada tanda tanya (?) biar boleh null
  final bool isIncome;

  TransactionModel({
    required this.title,
    required this.date,
    required this.amount,
    required this.status,
    this.iconAsset, // Tidak perlu required
    this.isIncome = false,
  });
}
