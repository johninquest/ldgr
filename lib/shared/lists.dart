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

  List<DropdownMenuItem<String>> personRoleList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'driver', child: Container(child: Text('Driver', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'manager', child: Container(child: Text('Manager', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'owner', child: Container(child: Text('Owner', style: DropdownListStyle),)),  
  ];

    List<DropdownMenuItem<String>> countryList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'algeria', child: Container(child: Text('Algeria', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'Angola', child: Container(child: Text('Angola', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'benin', child: Container(child: Text('Benin', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'botswana', child: Container(child: Text('Botswana', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'burkina_faso', child: Container(child: Text('Burkina Faso', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'burundi', child: Container(child: Text('Burundi', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'cabo verde', child: Container(child: Text('Cabo Verde', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'cameroon', child: Container(child: Text('Cameroon', style: DropdownListStyle),)),
      DropdownMenuItem(value: 'central_african_republic', child: Container(child: Text('Central African Republic', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'chad', child: Container(child: Text('Chad', style: DropdownListStyle),)),
      DropdownMenuItem(value: 'comoros', child: Container(child: Text('Comoros', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'congo_drc', child: Container(child: Text('Congo, DRC', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'congo_republic', child: Container(child: Text('Congo, Republic', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'ivory_coast', child: Container(child: Text('Cote Ivoire', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'djibouti', child: Container(child: Text('Djibouti', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'egypt', child: Container(child: Text('Egypt', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'equatorial_guinea', child: Container(child: Text('Equatorial Guinea', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'eritrea', child: Container(child: Text('Eritrea', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'dr_congo', child: Container(child: Text('Congo, DRC', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'eswatini', child: Container(child: Text('Eswatini', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'ethiopia', child: Container(child: Text('Ethiopia', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'gabon', child: Container(child: Text('Gabon', style: DropdownListStyle),)),   
      DropdownMenuItem(value: 'gambia', child: Container(child: Text('Gambia', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'ghana', child: Container(child: Text('Ghana', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'guinea', child: Container(child: Text('Guinea', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'guinea-bissau', child: Container(child: Text('Guinea-Bissau', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'kenya', child: Container(child: Text('Kenya', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'lesotho', child: Container(child: Text('Lesotho', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'liberia', child: Container(child: Text('Liberia', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'libya', child: Container(child: Text('Libya', style: DropdownListStyle),)),   
  ];
}