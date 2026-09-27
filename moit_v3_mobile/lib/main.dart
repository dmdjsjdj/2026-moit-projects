import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const MoitApp());
}

class MoitApp extends StatelessWidget {
  const MoitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOIT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF687EFF),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}