import 'package:flutter/material.dart';
import 'package:ldgr/styles/style.dart';

class FilterData {
  dayList() {
    List<DropdownMenuItem<String>> generatedList = [];
    for (int i = 1; i < 32; i++) {
      final item = DropdownMenuItem(
        value: '$i',
        child: Text('$i'),
      );
      generatedList.add(item);
    }
    return generatedList;
  }

  monthList() {
    List<DropdownMenuItem<String>> generatedList = [];
    for (int i = 1; i < 13; i++) {
      final item = DropdownMenuItem(
        value: '$i',
        child: Text('$i'),
      );
      generatedList.add(item);
    }
    return generatedList;
  }

  yearList() {
    int startYear = DateTime.now().year - 2;
    int endYear = DateTime.now().year + 3;
    List<DropdownMenuItem<String>> generatedList = [];
    for (int i = startYear; i < endYear; i++) {
      final item = DropdownMenuItem(
        value: '$i',
        child: Text('$i'),
      );
      generatedList.add(item);
    }
    return generatedList;
  }
}
