import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart';

class MyItemList {
    List<DropdownMenuItem<String>> incomeList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'delivery_service', child: Container(child: Text('Delivery service', style: ListItemStyle),)), 
      DropdownMenuItem(value: 'luggage', child: Container(child: Text('Luggage', style: ListItemStyle),)), 
      DropdownMenuItem(value: 'passengers', child: Container(child: Text('Passengers', style: ListItemStyle),)), 
      DropdownMenuItem(value: 'others', child: Container(child: Text('Other(s)', style: ListItemStyle),)), 
  ];

  List<DropdownMenuItem<String>> expenditureList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'car_repairs', child: Container(child: Text('Car repairs', style: ListItemStyle),),), 
      DropdownMenuItem(value: 'car_maintenance', child: Container(child: Text('Car maintenance', style: ListItemStyle),),),
      DropdownMenuItem(value: 'drinks', child: Container(child: Text('Drinks', style: ListItemStyle),),), 
      DropdownMenuItem(value: 'food', child: Container(child: Text('Food', style: ListItemStyle),),),
      DropdownMenuItem(value: 'fuel', child: Container(child: Text('Fuel', style: ListItemStyle),),), 
      DropdownMenuItem(value: 'park_fees', child: Container(child: Text('Park fees', style: ListItemStyle),),), 
      DropdownMenuItem(value: 'police_controls', child: Container(child: Text('Police controls', style: ListItemStyle),),),
      DropdownMenuItem(value: 'tollgate_fees', child: Container(child: Text('Tollgate fees', style: ListItemStyle),),), 
      DropdownMenuItem(value: 'others', child: Container(child: Text('Other(s)', style: ListItemStyle),),), 
  ];
}