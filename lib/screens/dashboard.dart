import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("LinkAja!", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: const Center(
        child: Text(
          "Dashboard LinkAja - Ready!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
