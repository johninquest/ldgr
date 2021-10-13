import 'package:flutter/material.dart';
import 'package:tba/styles/colors.dart';

const PageHeaderStyle =
    TextStyle(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 3.0); 

const AppBarTitleStyle =
    TextStyle(letterSpacing: 1.0);    

const BodyStyle = TextStyle(
    fontSize: 15.0, color: Color(0xFF0D47A1), fontWeight: FontWeight.bold);

const DropdownListStyle = TextStyle(fontWeight: FontWeight.normal);

const ListTitleStyle = TextStyle(fontWeight: FontWeight.bold);
const ListItemStyle = TextStyle(fontSize: 5.0);
const TableItemStyle = TextStyle(fontSize: 14.0); 

class StyleHandler {
  tableCategoryStyle(String category) {
    if (category == 'expenditure') {
      return TextStyle(
          color: myRed, fontWeight: FontWeight.bold);
    }
    if (category == 'income') {
      return TextStyle(
          color: myGreen,
          fontWeight: FontWeight.bold);
    }
  }
}
