import 'package:flutter/material.dart';
import 'package:latihan_responsi_praktpm/views/favorite_page.dart';
import 'package:latihan_responsi_praktpm/views/home_page.dart';
import 'package:latihan_responsi_praktpm/views/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    HomePage(),
    FavoritePage(),
    ProfilePage(),
  ];
  static const List<String> _appBarOptions = [
    "Beranda",
    "Favorite Saya",
    "Profile Saya",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 18, 32),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 18, 32),
        foregroundColor: Colors.white,
        title: Text(_appBarOptions[_selectedIndex]),
      ),
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 1, 18, 32),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
