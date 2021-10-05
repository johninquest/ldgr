import 'package:flutter/material.dart';
// import 'package:tba/pages/filters/overview.dart';
import 'package:tba/pages/records/all.dart';
// import 'package:tba/styles/style.dart';
import '../services/router.dart';
import 'package:tba/pages/home.dart';
// import 'records/all.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.blue[900],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      selectedIconTheme: IconThemeData(color: Colors.black),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      // iconSize: 30,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.white,
            size: 25.0,
          ),
          label: 'HOME',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.storage,
            color: Colors.white,
            size: 25.0,
          ),
          label: 'RECORDS',
        ),
      ],
      onTap: (index) => afterTap(index),
    );
  }

  void afterTap(int currentIndex) {
    if (currentIndex == 0) {
      PageRouter().navigateToPage(HomePage(), context);
    }
    if (currentIndex == 1) {
      PageRouter().navigateToPage(AllRecords(), context);
    }
/*
    else {
      print('No where to go');
    } */
  }
}
