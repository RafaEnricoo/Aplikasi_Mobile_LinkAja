import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQrisScreen extends StatefulWidget {
  const ScanQrisScreen({super.key});

  @override
  State<ScanQrisScreen> createState() => _ScanQrisScreenState();
}

class _ScanQrisScreenState extends State<ScanQrisScreen> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    torchEnabled: false,
  );

  bool isFlashOn = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. LAYAR KAMERA
          MobileScanner(
            controller: controller,
            errorBuilder: (context, error, child) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Error: ${error.errorCode}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Coba Cek Izin Kamera/Restart HP",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              );
            },
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                debugPrint('QR Code ditemukan: ${barcode.rawValue}');
              }
            },
          ),

          // 2. OVERLAY FRAME SCANNER
          _buildScannerOverlay(),

          // 3. TOP BAR
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                      const Text(
                        "Scan QRIS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFlashOn = !isFlashOn;
                            controller.toggleTorch();
                          });
                        },
                        icon: Icon(
                          isFlashOn ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.info_outline,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // 4. TOMBOL GALLERY
          Positioned(
            // Disesuaikan biar pas di atas bottom sheet yang baru
            bottom: 220,
            right: 20,
            child: InkWell(
              onTap: () {
                print("Buka Galeri");
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.photo_library_outlined,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // 5. BOTTOM SHEET (Panel Putih Bawah)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // --- UPDATE: Tingginya dikurangi biar lebih "mepet bawah" ---
              height: 200, // Tadinya 220
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(
                24,
                20,
                24,
                24,
              ), // Padding atas dikurangi dikit
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Other QRIS Method",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        // --- UPDATE: Opasitas 50% ---
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildOptionButton(
                          icon: Icons.qr_code_2,
                          label: "QRIS Code",
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildOptionButton(
                          icon: Icons.qr_code_scanner,
                          label: "Create Token",
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Center(
      child: SizedBox(
        width: 280,
        height: 280,
        child: Stack(
          children: [
            // --- Sudut-sudut Frame (Sama seperti sebelumnya) ---
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.white, width: 4),
                    left: BorderSide(color: Colors.white, width: 4),
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.white, width: 4),
                    right: BorderSide(color: Colors.white, width: 4),
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 4),
                    left: BorderSide(color: Colors.white, width: 4),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 4),
                    right: BorderSide(color: Colors.white, width: 4),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 250,
                height: 1,
                color: Colors.white.withOpacity(0.5),
              ),
            ),

            // --- UPDATE: Logo di bawah frame ---
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                // --- Padding dikurangi biar makin mepet bawah ---
                padding: const EdgeInsets.only(bottom: 8), // Tadinya 15
                child: Image.asset(
                  'assets/images/qris/qris.png', // JANGAN LUPA SESUAIKAN PATH INI
                  height: 28,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text(
                      "QRIS",
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
