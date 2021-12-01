import 'package:flutter/material.dart';
import 'package:ldgr/pages/records/all.dart';
import 'package:ldgr/pages/records/entrylist.dart';
import 'package:ldgr/styles/colors.dart';
import '../services/router.dart';
import 'package:ldgr/pages/home.dart';

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
      backgroundColor: myBlue,
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
      PageRouter().navigateToPage(EntryListPage(), context);
    }
/*
    else {
      print('No where to go');
    } */
  }
}
