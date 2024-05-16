import 'package:flutter/material.dart';
import 'package:medical_healthcare/pages/history_page.dart';
import 'package:medical_healthcare/pages/home_page.dart';
import 'package:medical_healthcare/pages/profile_page.dart';
import 'package:medical_healthcare/theme.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectIndex = 0;

  final _pageList = [
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  onTappedItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.account_box_rounded), label: "Profile"),
        ],
        currentIndex: _selectIndex,
        onTap: onTappedItem,
        unselectedItemColor: grey35Color,
        selectedItemColor: greenColor,
      ),
    );
  }
}

