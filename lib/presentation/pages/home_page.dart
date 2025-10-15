import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false, // biar ga muncul tombol back
        backgroundColor: Colors.white,
        elevation: 0, // hilangin shadow bawah
        titleSpacing: 16, // kasih jarak dikit dari kiri
        title: Row(
          children: [
            Image.asset(
              'assets/logos/tmbd-horizontal.png',
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // aksi notifikasi
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF3D5AFE),
              size: 26,
            ),
          ),
          IconButton(
            onPressed: () {
              // aksi notifikasi
            },
            icon: const Icon(
              Icons.search_outlined,
              color: Color(0xFF3D5AFE),
              size: 26,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: const [],
        ),
      ),
    );
  }
}
