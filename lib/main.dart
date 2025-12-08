import 'package:flutter/material.dart';
import 'screens/dashboard.dart';

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
      home: const DashboardScreen(), // arahkan ke dashboard
    );
  }
}