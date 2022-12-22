import 'package:flutter/material.dart';
import '../pages/expense/expense_list.dart';
import '../pages/home.dart';
import '../utils/router.dart';
import '../styles/colors.dart';

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
      backgroundColor: primaryColor,
      selectedItemColor: blackColor,
      /* unselectedItemColor: blackColor,
      selectedIconTheme: IconThemeData(color: Colors.black), */
      showSelectedLabels: false,
      showUnselectedLabels: false,
      // iconSize: 30,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.add_box_outlined,
          ),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list_alt_outlined,
          ),
          label: 'Expense list',
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
      // PageRouter().navigateToPage(EntryListPage(), context);
      print('Tapped add button');
    }
    if (currentIndex == 2) {
      PageRouter().navigateToPage(EntryListPage(), context);
    }
/*
    else {
      print('No where to go');
    } */
  }
}
