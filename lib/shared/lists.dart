import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart';

class MyItemList {
    List<DropdownMenuItem<String>> incomeList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'delivery_service', child: Container(child: Text('Delivery service', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'luggage', child: Container(child: Text('Luggage', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'passengers', child: Container(child: Text('Passengers', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'others', child: Container(child: Text('Other(s)', style: DropdownListStyle),)), 
  ];

  List<DropdownMenuItem<String>> expenditureList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'car_repairs', child: Container(child: Text('Car repairs', style: DropdownListStyle),),), 
      DropdownMenuItem(value: 'car_maintenance', child: Container(child: Text('Car maintenance', style: DropdownListStyle),),),
      DropdownMenuItem(value: 'drinks', child: Container(child: Text('Drinks', style: DropdownListStyle),),), 
      DropdownMenuItem(value: 'food', child: Container(child: Text('Food', style: DropdownListStyle),),),
      DropdownMenuItem(value: 'fuel', child: Container(child: Text('Fuel', style: DropdownListStyle),),), 
      DropdownMenuItem(value: 'park_fees', child: Container(child: Text('Park fees', style: DropdownListStyle),),), 
      DropdownMenuItem(value: 'police_controls', child: Container(child: Text('Police controls', style: DropdownListStyle),),),
      DropdownMenuItem(value: 'tollgate_fees', child: Container(child: Text('Tollgate fees', style: DropdownListStyle),),), 
      DropdownMenuItem(value: 'others', child: Container(child: Text('Other(s)', style: DropdownListStyle),),), 
  ];
}