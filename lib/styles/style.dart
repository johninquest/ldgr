import 'package:flutter/material.dart';
import 'package:tba/styles/colors.dart';

const PageHeaderStyle =
    TextStyle(fontWeight: FontWeight.bold, color: Colors.white);

const BodyStyle = TextStyle(
    fontSize: 15.0, color: Color(0xFF0D47A1), fontWeight: FontWeight.bold);

const DropdownListStyle = TextStyle(fontWeight: FontWeight.bold);

const ListTitleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0);
const ListItemStyle = TextStyle(fontSize: 5.0);
// const ListItemStyle = TextStyle(fontWeight: FontWeight.bold);
const TableItemStyle = TextStyle(fontSize: 14.0);

class StyleHandler {
  tableCategoryStyle(String category) {
    if (category == 'expenditure') {
      return TextStyle(
          fontSize: 14.0, color: myRed, fontWeight: FontWeight.bold);
    }
    if (category == 'income') {
      return TextStyle(
          fontSize: 14.0,
          color: myGreen,
          fontWeight: FontWeight.bold);
    }
  }
}
