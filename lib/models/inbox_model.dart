class InboxModel {
  final String title;
  final String description;
  final String date;
  final String type; // 'info' or 'promo'
  final bool isUnread;

  InboxModel({
    required this.title,
    required this.description,
    required this.date,
    required this.type,
    this.isUnread = false,
  });
}