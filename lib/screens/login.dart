import 'package:flutter/material.dart';
import 'dashboard.dart'; // Import Dashboard agar bisa masuk setelah login

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Tombol back hitam
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Logo Kecil
            Image.asset(
              'assets/images/landing_page/logo_linkaja.png', // Pakai logo yang sama
              height: 40,
              errorBuilder: (ctx, err, stack) => const Icon(Icons.account_balance_wallet, color: Colors.red, size: 40),
            ),
            const SizedBox(height: 40),
            
            // Judul
            const Text(
              "Enter your phone number\nto continue",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            
            const SizedBox(height: 30),

            // Input Field (Nomor HP)
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                prefixText: "+62 ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE52326)),
                ),
              ),
            ),

            const Spacer(),

            // Tombol Login / Continue
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // --- MASUK KE DASHBOARD ---
                  // Gunakan pushAndRemoveUntil agar user GAK BISA BACK ke halaman login
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardScreen()),
                    (route) => false, // Hapus semua riwayat halaman sebelumnya
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE52326),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}