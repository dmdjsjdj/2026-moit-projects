import 'package:flutter/material.dart';

import '../../widgets/advertisement_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MOIT'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const SizedBox(height: 20),

          const Text(
            'MOIT',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            '관심사를 함께하는 모임',
            style: TextStyle(
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 24),

          // ==============================
          // 광고
          // ==============================

          const AdvertisementBanner(
            position: 'MAIN',
          ),

          const SizedBox(height: 24),

          const Text(
            '인기 모임',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          // TODO
          // 인기 모임 Flutter 구현
        ],
      ),
    );
  }
}