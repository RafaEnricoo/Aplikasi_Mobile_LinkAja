import 'package:flutter/material.dart';
import 'dashboard.dart'; // Import dashboard untuk navigasi

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _enteredPin = "";
  final int _pinLength = 6;

  void _onKeyPressed(String value) {
    if (_enteredPin.length < _pinLength) {
      setState(() {
        _enteredPin += value;
      });
      if (_enteredPin.length == _pinLength) {
        _submitLogin();
      }
    }
  }

  void _onDeletePressed() {
    if (_enteredPin.isNotEmpty) {
      setState(() {
        _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
      });
    }
  }

  void _submitLogin() {
    Future.delayed(const Duration(milliseconds: 300), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      // --- CUSTOM APP BAR ---
      // Kita ganti AppBar biasa dengan PreferredSize agar bisa pakai Container + Dekorasi
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // Tinggi Header
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Background Shape Putih
            
            // 1. STROKE / BORDER BAWAH
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade200, // Warna stroke tipis
                width: 1.0,
              ),
            ),
            
            // 2. SHADOW (BAYANGAN DI BAWAH HEADER)
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04), // Bayangan halus
                offset: const Offset(0, 4), // Arah bayangan ke bawah
                blurRadius: 6, // Keburaman bayangan
              ),
            ],
          ),
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Tombol Back (Kiri)
                Positioned(
                  left: 8, // Jarak dari kiri
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                
                // Teks "Login" (Tengah)
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 40),
          
          // --- INSTRUKSI ---
          const Text(
            "Input PIN",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Please enter your PIN",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 40),

          // --- INDIKATOR PIN ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pinLength, (index) {
              bool isFilled = index < _enteredPin.length;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 16, 
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isFilled ? const Color(0xFFED1C24) : Colors.transparent, 
                  border: Border.all(
                    color: isFilled ? const Color(0xFFED1C24) : Colors.grey.shade400,
                    width: 1.5,
                  ),
                ),
              );
            }),
          ),

          const Spacer(),

          // --- FORGOT PIN ---
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Forgot PIN? ",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
              GestureDetector(
                onTap: () {
                  print("Reset clicked");
                },
                child: const Text(
                  "Reset",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // --- KEYPAD ---
          Container(
            padding: const EdgeInsets.only(bottom: 40, left: 40, right: 40),
            child: Column(
              children: [
                _buildKeypadRow(['1', '2', '3']),
                const SizedBox(height: 20),
                _buildKeypadRow(['4', '5', '6']),
                const SizedBox(height: 20),
                _buildKeypadRow(['7', '8', '9']),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 60, height: 60), 
                    _buildKeypadButton('0'),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: InkWell(
                        onTap: _onDeletePressed,
                        borderRadius: BorderRadius.circular(30),
                        child: const Icon(Icons.backspace_outlined, size: 28, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: keys.map((key) {
        return _buildKeypadButton(key);
      }).toList(),
    );
  }

  Widget _buildKeypadButton(String value) {
    return SizedBox(
      width: 60,
      height: 60,
      child: InkWell(
        onTap: () => _onKeyPressed(value),
        borderRadius: BorderRadius.circular(30),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}