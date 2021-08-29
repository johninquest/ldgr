import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart';
import '../services/router.dart';
import 'package:tba/pages/home.dart';
import 'all_records.dart';

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
        /* BottomNavigationBarItem(
            icon: Icon(
              Icons.storage,
              color: Colors.white,
              size: 25.0,
            ),
            label: 'AUFZEICHNUNGEN') */
      ],
      onTap: (index) => afterTap(index),
    );
  }

  void afterTap(int currentIndex) {
    if (currentIndex == 0) {
      PageRouter().navigateToPage(HomePage(), context);
    }
    if (currentIndex == 1) {
      // print('Pressed 1');
      PageRouter().navigateToPage(AllRecordsPage(), context);
    }
    /*if (currentIndex == 2) {
       print('Pressed 2');
      // PageRouter().navigateToPage(TimingDataPage(), context);
    }
    else {
      print('No where to go');
    } */
  }
}
