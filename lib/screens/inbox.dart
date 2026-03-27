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
      date: "27 Mar 2026 • 14:30",
      type: "info",
      isUnread: true, 
    ),
    InboxModel(
      title: "Payday Time!",
      description: "Save up to IDR 200,000 on your monthly bill payments.",
      date: "25 Mar 2026 • 09:00",
      type: "promo",
      isUnread: true, 
    ),
    InboxModel(
      title: "Cash Withdrawal with LinkAja! at ATM",
      description: "Easy and practical without a card at Himbara ATMs!",
      date: "23 Mar 2026 • 11:15",
      type: "promo",
      isUnread: false, 
    ),
    InboxModel(
      title: "Transaction Successful",
      description: "Your Postpaid PLN bill payment of IDR 150,000 was successful.",
      date: "15 Mar 2026 • 08:20",
      type: "info",
      isUnread: false,
    ),
    InboxModel(
      title: "Transfer Successful",
      description: "You have successfully transferred IDR 100,000 to John Doe.",
      date: "28 Feb 2026 • 19:45",
      type: "info",
      isUnread: false,
    ),
    InboxModel(
      title: "Exclusive Merchant Discount",
      description: "Scan QRIS at our partner merchants and enjoy up to 30% instant discount.",
      date: "25 Feb 2026 • 12:30",
      type: "promo",
      isUnread: true,
    ),
    InboxModel(
      title: "Welcome to LinkAja!",
      description: "Thank you for registering. Start making your daily transactions easier with us.",
      date: "20 Feb 2026 • 08:00",
      type: "info",
      isUnread: false,
    ),
    InboxModel(
      title: "Year-End Mega Sale!",
      description: "Celebrate the end of 2025 with up to 90% discount on selected merchants.",
      date: "25 Dec 2025 • 10:00",
      type: "promo",
      isUnread: true,
    ),
    InboxModel(
      title: "System Update Complete",
      description: "Our year-end system upgrade is complete. Thank you for your patience.",
      date: "20 Dec 2025 • 06:30",
      type: "info",
      isUnread: false,
    ),
    InboxModel(
      title: "11.11 Flash Sale Extravaganza",
      description: "The biggest sale of the year is here! Claim your exclusive cashback vouchers now.",
      date: "11 Nov 2025 • 11:11",
      type: "promo",
      isUnread: false,
    ),
    InboxModel(
      title: "Bill Payment Successful",
      description: "Your BPJS Kesehatan payment for November 2025 has been processed.",
      date: "05 Nov 2025 • 09:15",
      type: "info",
      isUnread: false,
    ),
    InboxModel(
      title: "Spooky Halloween Treats",
      description: "Trick or treat? Get a special sweet discount when you pay with LinkAja today.",
      date: "31 Oct 2025 • 18:00",
      type: "promo",
      isUnread: false,
    ),
    InboxModel(
      title: "Security Policy Update",
      description: "We have updated our privacy policy to serve you better. Tap to read the details.",
      date: "15 Oct 2025 • 14:00",
      type: "info",
      isUnread: false,
    ),
    InboxModel(
      title: "Payday Promo September",
      description: "Treat yourself! Enjoy free delivery for your food orders this payday weekend.",
      date: "26 Sep 2025 • 12:00",
      type: "promo",
      isUnread: false,
    ),
    InboxModel(
      title: "Independence Day Special",
      description: "Merdeka! Get exactly IDR 17,845 cashback for your first transaction today.",
      date: "17 Aug 2025 • 08:45",
      type: "promo",
      isUnread: false,
    ),
    InboxModel(
      title: "School Holiday Special",
      description: "Enjoy up to 50% off on theme park tickets for your family vacation.",
      date: "10 Jul 2025 • 09:30",
      type: "promo",
      isUnread: true,
    ),
    InboxModel(
      title: "Welcome to Premium",
      description: "Your account has been upgraded to Full Service. Enjoy higher limits and more features!",
      date: "02 Jul 2025 • 16:20",
      type: "info",
      isUnread: false,
    ),
    InboxModel(
      title: "Mid-Year Super Sale",
      description: "Grab your favorite items with discounts up to 70% off. Limited time only!",
      date: "15 Jun 2025 • 11:00",
      type: "promo",
      isUnread: false,
    ),
    InboxModel(
      title: "Login Alert",
      description: "A new login was detected on a new device. Review your account activity now.",
      date: "05 May 2025 • 20:45",
      type: "info",
      isUnread: true,
    ),
    InboxModel(
      title: "Top Up Successful",
      description: "Your balance top-up of IDR 1,000,000 via Mobile Banking was successful.",
      date: "20 Apr 2025 • 14:15",
      type: "info",
      isUnread: false,
    ),
    InboxModel(
      title: "Easter Egg-Stravaganza",
      description: "Find the golden egg in our app and win a special prize up to IDR 500,000.",
      date: "12 Apr 2025 • 08:00",
      type: "promo",
      isUnread: false,
    ),
    InboxModel(
      title: "Scheduled Maintenance",
      description: "Our system will undergo scheduled maintenance on 25 March from 02:00 to 04:00 AM.",
      date: "22 Mar 2025 • 10:30",
      type: "info",
      isUnread: false,
    ),
    InboxModel(
      title: "Valentine's Day Treat",
      description: "Buy 1 get 1 free movie tickets for you and your loved one this Valentine's.",
      date: "14 Feb 2025 • 17:00",
      type: "promo",
      isUnread: false,
    ),
    InboxModel(
      title: "Transaction Summary",
      description: "Your monthly transaction summary for January 2025 is ready to view.",
      date: "05 Feb 2025 • 09:00",
      type: "info",
      isUnread: false,
    ),
    InboxModel(
      title: "New Year, New Gadget!",
      description: "Stand a chance to win a new smartphone by doing at least 5 transactions this month.",
      date: "10 Jan 2025 • 12:00",
      type: "promo",
      isUnread: true,
    ),
    InboxModel(
      title: "Account Verified",
      description: "Your identity verification process is complete. Thank you for your cooperation.",
      date: "15 Dec 2024 • 15:20",
      type: "info",
      isUnread: false,
    ),
    InboxModel(
      title: "Black Friday Deals",
      description: "Unbeatable discounts at our partner merchants today! Don't miss out.",
      date: "29 Nov 2024 • 08:00",
      type: "promo",
      isUnread: false,
    ),
    InboxModel(
      title: "Account Creation Successful",
      description: "Welcome to LinkAja! Explore our features and enjoy seamless transactions.",
      date: "01 Nov 2024 • 10:00",
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

  // --- LOGIKA MENCARI NAMA BULAN ---
  String _getFullMonthName(String shortMonth) {
    switch (shortMonth) {
      case 'Jan': return 'January';
      case 'Feb': return 'February';
      case 'Mar': return 'March';
      case 'Apr': return 'April';
      case 'May': return 'May';
      case 'Jun': return 'June';
      case 'Jul': return 'July';
      case 'Aug': return 'August';
      case 'Sep': return 'September';
      case 'Oct': return 'October';
      case 'Nov': return 'November';
      case 'Dec': return 'December';
      default: return shortMonth;
    }
  }

  // --- LOGIKA EKSTRAK BULAN & TAHUN DARI TANGGAL ---
  String _getMonthYear(String dateString) {
    try {
      // Format data kita: "27 Mar 2026 • 14:30"
      List<String> parts = dateString.split(' ');
      if (parts.length >= 3) {
        String fullMonth = _getFullMonthName(parts[1]);
        return "$fullMonth ${parts[2]}"; // Hasil: "March 2026"
      }
    } catch (e) {
      // Abaikan error format
    }
    return "";
  }

  // --- LOGIKA MEMBUAT LIST DENGAN HEADER DINAMIS ---
  List<Widget> _buildInboxListWithHeaders(List<InboxModel> list) {
    List<Widget> widgets = [];
    String currentMonthYear = "";

    for (var data in list) {
      String itemMonthYear = _getMonthYear(data.date);
      
      // Jika bulannya berbeda dengan item sebelumnya, buat header baru
      if (itemMonthYear != currentMonthYear && itemMonthYear.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Text(
              itemMonthYear,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );
        widgets.add(const Divider(thickness: 1, height: 1, color: Color(0xFFEEEEEE)));
        currentMonthYear = itemMonthYear; // Update bulan saat ini
      }

      // Tambahkan data itemnya ke bawah header
      widgets.add(_buildInboxItem(data));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final displayList = _filteredList;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 20),
                _buildFilterRow(),
                const SizedBox(height: 10), 

                // Menampilkan Data dengan Grouping Bulan
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
                  ..._buildInboxListWithHeaders(displayList),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 45, height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.image, size: 20, color: Colors.grey),
              );
            },
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