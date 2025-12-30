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
  
  // PIN YANG BENAR
  final String _correctPin = "123456"; 

  void _onKeyPressed(String value) {
    if (_enteredPin.length < _pinLength) {
      setState(() {
        _enteredPin += value;
      });

      if (_enteredPin.length == _pinLength) {
        if (_enteredPin == _correctPin) {
          _submitLogin();
        } else {
          _handleWrongPin();
        }
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

  void _handleWrongPin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("PIN Salah! Coba masukan 123456"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ),
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _enteredPin = ""; 
      });
    });
  }

  void _submitLogin() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator(color: Color(0xFFED1C24))),
    );

    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.pop(context); 
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
      backgroundColor: Colors.white, // Background utama tetap putih
      
      // HEADER (Mirip desain Keypad nanti)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade200, width: 1.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                offset: const Offset(0, 4),
                blurRadius: 6,
              ),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 40),
          
          // INSTRUKSI
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
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),

          const SizedBox(height: 30),

          // INDIKATOR PIN
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_pinLength, (index) {
              bool isFilled = index < _enteredPin.length;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 16, 
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isFilled 
                      ? const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFF5C5C), 
                            Color(0xFFED1C24), 
                          ],
                        )
                      : null,
                  border: isFilled 
                      ? null 
                      : Border.all(color: const Color.fromARGB(255, 212, 212, 212), width: 1.5),
                ),
              );
            }),
          ),

          // Spacer ini mendorong konten Forgot PIN & Keypad ke bawah
          const Spacer(),

          // --- FORGOT PIN (DILUAR BACKGROUND KEYPAD) ---
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0), // Jarak ke Keypad Panel
            child: Row(
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
          ),

          // --- KEYPAD PANEL (BACKGROUND HEADER STYLE) ---
          Container(
            width: double.infinity, // Lebar penuh
            padding: const EdgeInsets.only(top: 30, bottom: 40, left: 40, right: 40),
            
            // DEKORASI MIRIP HEADER (Tapi shadow & border di atas)
            decoration: BoxDecoration(
              color: Colors.white, // Warna dasar panel

              
              // Shadow mengarah ke ATAS (offset -4)
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, -1), 
                ),
              ],
            ),
            
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