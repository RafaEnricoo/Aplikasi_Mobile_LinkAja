import 'package:flutter/material.dart';

// Model Data
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

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final Color brandRed = const Color(0xFFE52326);

  // --- DATA MASTER ---
  final List<InboxModel> _inboxList = [
    InboxModel(
      title: "Info LinkAja",
      description: "Sorry, your PIN or password is incorrect, please check and try again.",
      date: "12 Sep 2025 • 00:00",
      type: "info",
      isUnread: true, 
    ),
    InboxModel(
      title: "Info LinkAja",
      description: "Sorry, your PIN or password is incorrect, please check and try again.",
      date: "12 Sep 2025 • 00:00",
      type: "info",
      isUnread: true, 
    ),
    InboxModel(
      title: "Payday Time!",
      description: "Save up to IDR 200,000",
      date: "12 Sep 2025 • 00:00",
      type: "promo",
      isUnread: true, 
    ),
    InboxModel(
      title: "Cash Withdrawal with LinkAja! at ATM",
      description: "Easy and practical without a card!",
      date: "12 Sep 2025 • 00:00",
      type: "promo",
      isUnread: true, 
    ),
    InboxModel(
      title: "Verification Success",
      description: "Email has been verified. You can use this email to recover your account.",
      date: "12 Sep 2025 • 00:00",
      type: "info",
      isUnread: false, 
    ),
  ];

  int _selectedFilterIndex = 0; 

  // --- LOGIKA FILTER ---
  List<InboxModel> get _filteredList {
    switch (_selectedFilterIndex) {
      case 1: // Unread
        return _inboxList.where((item) => item.isUnread == true).toList();
      case 2: // Promo
        return _inboxList.where((item) => item.type == 'promo').toList();
      case 3: // Info
        return _inboxList.where((item) => item.type == 'info').toList();
      case 0: // All Inbox
      default:
        return _inboxList;
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayList = _filteredList;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. Header (Updated)
          _buildHeader(),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 20),
                _buildFilterRow(),
                const SizedBox(height: 40), 
                
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    "September 2025",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                const Divider(thickness: 1, height: 1, color: Color(0xFFEEEEEE)),

                // Tampilkan Data
                if (displayList.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: Text(
                        "No messages here",
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  )
                else
                  ...displayList.map((data) => _buildInboxItem(data)),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- HEADER (POSISI DIPERBAIKI) ---
  Widget _buildHeader() {
    return Container(
      // Tinggi total header (disamakan kurleb dengan visual login)
      height: 100, 
      width: double.infinity,
      decoration: BoxDecoration(
        color: brandRed,
        image: const DecorationImage(
          image: AssetImage('assets/images/history/header.png'), 
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Container(
          // --- KUNCI POSISI ---
          // Kita buat wadah setinggi 60px (standar Toolbar/AppBar)
          // Lalu kita 'Center' teks di dalamnya.
          // Ini menjamin posisinya sama persis dengan 'Login' yang pakai AppBar.
          height: 60,
          alignment: Alignment.center, 
          child: const Text(
            "Inbox",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFilterItem(0, "All Inbox", "all_inbox"),
          _buildFilterItem(1, "Unread", "unread"),
          _buildFilterItem(2, "Promo", "promo"),
          _buildFilterItem(3, "Information", "info"),
        ],
      ),
    );
  }

  Widget _buildFilterItem(int index, String label, String assetBaseName) {
    bool isActive = _selectedFilterIndex == index;
    String suffix = isActive ? '1' : '0';
    String imagePath = 'assets/images/inbox/$assetBaseName$suffix.png';

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilterIndex = index;
        });
      },
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 55,
            height: 55,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 55, height: 55, 
                color: Colors.grey[200], 
                child: const Icon(Icons.broken_image, size: 20),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? brandRed : Colors.grey[600],
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInboxItem(InboxModel data) {
    String listIconAsset = data.type == 'promo' 
        ? 'assets/images/inbox/promo2.png' 
        : 'assets/images/inbox/info2.png';
    
    final Color textColor = data.isUnread ? Colors.black87 : Colors.grey;
    final Color descColor = data.isUnread ? Colors.black87 : Colors.grey[400]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            listIconAsset,
            width: 45,
            height: 45,
            fit: BoxFit.contain,
          ),
          
          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: textColor, 
                      ),
                    ),
                    
                    if (data.isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: brandRed,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  data.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: descColor,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.date,
                  style: TextStyle(
                    fontSize: 11,
                    color: textColor, 
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}