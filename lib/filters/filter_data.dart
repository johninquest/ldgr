import 'package:flutter/material.dart';
import 'package:ldgr/styles/style.dart';

class FilterData {
  testDayList() {
    List<DropdownMenuItem<String>> dayL = [];
    for (var i = 1; i < 32; i++) {
      var item = DropdownMenuItem(
        value: '$i',
        child: Text('$i'),
      );
      dayL.add(item);
    }
    return dayL;
  }

  List<DropdownMenuItem<String>> dayList = [
    DropdownMenuItem(
        value: '1',
        child: Container(
          child: Text('1'),
        )),
    DropdownMenuItem(
        value: '2',
        child: Container(
          child: Text('2'),
        )),
    DropdownMenuItem(
        value: '3',
        child: Container(
          child: Text('3'),
        )),
    DropdownMenuItem(
        value: '4',
        child: Container(
          child: Text('4'),
        )),
    DropdownMenuItem(
        value: '5',
        child: Container(
          child: Text('5'),
        )),
    DropdownMenuItem(
        value: '6',
        child: Container(
          child: Text('6'),
        )),
    DropdownMenuItem(
        value: '7',
        child: Container(
          child: Text('7'),
        )),
    DropdownMenuItem(
        value: '8',
        child: Container(
          child: Text('8'),
        )),
    DropdownMenuItem(
        value: '9',
        child: Container(
          child: Text('9'),
        )),
    DropdownMenuItem(
        value: '10',
        child: Container(
          child: Text('10'),
        )),
    DropdownMenuItem(
        value: '11',
        child: Container(
          child: Text('11'),
        )),
    DropdownMenuItem(
        value: '12',
        child: Container(
          child: Text('12'),
        )),
    DropdownMenuItem(
        value: '13',
        child: Container(
          child: Text('13'),
        )),
    DropdownMenuItem(
        value: '14',
        child: Container(
          child: Text('10'),
        )),
  ];

  List<DropdownMenuItem<String>> monthList = [
    DropdownMenuItem(
        value: '',
        child: Container(
          child: Text(''),
        )),
    DropdownMenuItem(
        value: '1',
        child: Container(
          child: Text('1'),
        )),
    DropdownMenuItem(
        value: '2',
        child: Container(
          child: Text('2'),
        )),
    DropdownMenuItem(
        value: '3',
        child: Container(
          child: Text('3'),
        )),
    DropdownMenuItem(
        value: '4',
        child: Container(
          child: Text('4'),
        )),
    DropdownMenuItem(
        value: '5',
        child: Container(
          child: Text('5'),
        )),
    DropdownMenuItem(
        value: '6',
        child: Container(
          child: Text('6'),
        )),
    DropdownMenuItem(
        value: '7',
        child: Container(
          child: Text('7'),
        )),
    DropdownMenuItem(
        value: '8',
        child: Container(
          child: Text('8'),
        )),
    DropdownMenuItem(
        value: '9',
        child: Container(
          child: Text('9'),
        )),
    DropdownMenuItem(
        value: '10',
        child: Container(
          child: Text('10'),
        )),
    DropdownMenuItem(
        value: '11',
        child: Container(
          child: Text('11'),
        )),
    DropdownMenuItem(
        value: '12',
        child: Container(
          child: Text('12'),
        )),
  ];

  List<DropdownMenuItem<String>> yearList = [
    DropdownMenuItem(
        value: '',
        child: Container(
          child: Text(''),
        )),
    DropdownMenuItem(
        value: '2020',
        child: Container(
          child: Text('2020'),
        )),
    DropdownMenuItem(
        value: '2021',
        child: Container(
          child: Text('2021'),
        )),
    DropdownMenuItem(
        value: '2022',
        child: Container(
          child: Text('2022'),
        )),
    DropdownMenuItem(
        value: '2023',
        child: Container(
          child: Text('2023'),
        )),
  ];
}
