import 'package:flutter/material.dart';
import 'screens/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/dashboard.dart';
import 'screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "LinkAja!",
      theme: ThemeData(
        primaryColor: Colors.red,
        fontFamily: "Poppins", // nanti bisa diganti sesuai desainmu
      ),
      home: const SplashScreenCheck(),
    );
  }
}

class SplashScreenCheck extends StatefulWidget {
  const SplashScreenCheck({super.key});

  @override
  State<SplashScreenCheck> createState() => _SplashScreenCheckState();
}

class _SplashScreenCheckState extends State<SplashScreenCheck> {
  @override
  void initState() {
    super.initState();
    _checkSession(); // Jalankan pengecekan pas aplikasi dibuka
  }

  Future<void> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Tambahin variabel khusus buat ngecek Onboarding
    // Default-nya 'true' kalau user baru pertama kali install
    bool isFirstTime = prefs.getBool('is_first_time') ?? true;

    // 2. Data login & waktu (TETAP SAMA)
    bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    int lastExitTime = prefs.getInt('last_exit_time') ?? 0;
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int difference = currentTime - lastExitTime;

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    if (isFirstTime) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
      );
    } else {
      if (isLoggedIn) {
        if (lastExitTime != 0 && difference < 300000) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/landing_page/logo.png',
          height: 100,
          width: 100,
        ),
      ),
    );
  }
}
