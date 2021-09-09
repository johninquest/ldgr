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

      List<DropdownMenuItem<String>> vehicleMakerList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'audi', child: Container(child: Text('AUDI', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'bmw', child: Container(child: Text('BMW', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'ford', child: Container(child: Text('FORD', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'hyundai', child: Container(child: Text('HYUNDAI', style: DropdownListStyle),)),
      DropdownMenuItem(value: 'isuzu', child: Container(child: Text('ISUZU', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'mercedes', child: Container(child: Text('MERCEDES', style: DropdownListStyle),)),
      DropdownMenuItem(value: 'nissan', child: Container(child: Text('NISSAN', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'peugeot', child: Container(child: Text('PEUGEOT', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'renault', child: Container(child: Text('RENAULT', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'toyota', child: Container(child: Text('TOYOTA', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'volkswagen', child: Container(child: Text('VW', style: DropdownListStyle),)),
  ];
}