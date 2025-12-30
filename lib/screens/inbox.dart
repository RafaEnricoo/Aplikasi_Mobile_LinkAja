import 'package:flutter/material.dart';

// Definisi Model data di file yang sama (biar praktis)
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
  // --- WARNA ---
  final Color brandRed = const Color(0xFFE52326);
  final Color lightRedBg = const Color(0xFFFFEBEB); // Warna bg icon bulat

  // --- DATA DUMMY (Sesuai Gambar) ---
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
      description: "Email has been verified. You can use this email to recover your account or charge your pin when you forget.",
      date: "12 Sep 2025 • 00:00",
      type: "info",
      isUnread: false, // Sudah dibaca (tidak ada titik merah)
    ),
  ];

  int _selectedFilterIndex = 0; // 0: All, 1: Unread, 2: Promo, 3: Info

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. HEADER MERAH
          _buildHeader(),

          // 2. KONTEN SCROLLABLE
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 20),

                // --- FILTER MENU (ICON BULAT) ---
                _buildFilterRow(),

                const SizedBox(height: 20),
                const Divider(thickness: 1, height: 1, color: Color(0xFFEEEEEE)),

                // --- LABEL BULAN ---
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Text(
                    "September 2025",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                // --- LIST ITEM ---
                ..._inboxList.map((data) => _buildInboxItem(data)),

                // Padding bawah agar tidak ketutup Navbar
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET HEADER MERAH ---
  Widget _buildHeader() {
    return Container(
      height: 110, // Sesuaikan tinggi
      width: double.infinity,
      decoration: BoxDecoration(
        color: brandRed,
        image: const DecorationImage(
          // Gunakan asset header yang sama dengan history jika ada
          image: AssetImage('assets/images/history/header.png'), 
          fit: BoxFit.cover,
          opacity: 0.5, // Biar tidak terlalu nabrak teks
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: const Text(
              "Inbox",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGET FILTER ROW ---
  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFilterItem(0, "All Inbox", Icons.mark_email_unread_outlined, isActive: true),
          _buildFilterItem(1, "Unread", Icons.mail_outline),
          _buildFilterItem(2, "Promo", Icons.percent),
          _buildFilterItem(3, "Information", Icons.info_outline),
        ],
      ),
    );
  }

  Widget _buildFilterItem(int index, String label, IconData icon, {bool isActive = false}) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? const Color(0xFFFFEBEB) : Colors.grey[100],
                border: isActive 
                  ? Border.all(color: const Color(0xFFFFCCCC)) 
                  : Border.all(color: Colors.transparent),
              ),
              child: Icon(
                icon,
                color: isActive ? brandRed : Colors.grey[600],
                size: 24,
              ),
            ),
            // Red Dot Badge (Hiasan)
            Positioned(
              top: 2,
              right: 2,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: brandRed,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
          ],
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
    );
  }

  // --- WIDGET LIST ITEM ---
  Widget _buildInboxItem(InboxModel data) {
    // Tentukan icon berdasarkan tipe
    IconData iconData = data.type == 'promo' ? Icons.percent : Icons.info_outline;
    
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
          // 1. Icon Bulat Kiri
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: lightRedBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              color: brandRed,
              size: 22,
            ),
          ),
          
          const SizedBox(width: 15),

          // 2. Teks Konten
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    // Dot merah kalau unread
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
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.date,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
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