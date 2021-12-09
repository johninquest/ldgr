import 'package:flutter/material.dart';
import 'package:ldgr/styles/style.dart';

class MyItemList {

  List<DropdownMenuItem<String>> accountList = [
    DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'expense', child: Container(child: Text('Expense'),)), 
      DropdownMenuItem(value: 'income', child: Container(child: Text('Income', style: DropdownListStyle),)),    
  ];

  List<DropdownMenuItem<String>> businessTypeList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'bar', child: Container(child: Text('Bar', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'cafe', child: Container(child: Text('Café', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'restaurant', child: Container(child: Text('Restaurant', style: DropdownListStyle),)),  
  ];

  List<DropdownMenuItem<String>> costAreaList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'bar', child: Container(child: Text('Bar', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'cleaning', child: Container(child: Text('Cleaning', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'kitchen', child: Container(child: Text('Kitchen', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'operation', child: Container(child: Text('Operation', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'others', child: Container(child: Text('Other(s)', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'restaurant', child: Container(child: Text('Restaurant', style: DropdownListStyle),)),
      DropdownMenuItem(value: 'toilet', child: Container(child: Text('Toilet', style: DropdownListStyle),)),  
  ];


  List<DropdownMenuItem<String>> barItemList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'beer', child: Container(child: Text('Beer'),)),
      DropdownMenuItem(value: 'fruits', child: Container(child: Text('Fruits (Cocktail)', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'liquor', child: Container(child: Text('Liquor', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'wine', child: Container(child: Text('Wine', style: DropdownListStyle),)),
      DropdownMenuItem(value: 'others', child: Container(child: Text('Other(s)', style: DropdownListStyle),)),  
  ];

  List<DropdownMenuItem<String>> kitchenItemList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'beef_filet', child: Container(child: Text('Beef filet'),)), 
      DropdownMenuItem(value: 'chicken', child: Container(child: Text('Chicken'),)), 
      DropdownMenuItem(value: 'fish_filet', child: Container(child: Text('Fish filet'),)), 
      DropdownMenuItem(value: 'gas', child: Container(child: Text('Gas'),)),
      DropdownMenuItem(value: 'milk', child: Container(child: Text('Milk'),)),
      DropdownMenuItem(value: 'simba_store', child: Container(child: Text('Simba store'),)),
      DropdownMenuItem(value: 'vegetables', child: Container(child: Text('Vegetables', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'others', child: Container(child: Text('Other(s)', style: DropdownListStyle),)),   
  ];

  List<DropdownMenuItem<String>> operatingCostsItemList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'electricity', child: Container(child: Text('Electricity', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'rent', child: Container(child: Text('Rent', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'salary', child: Container(child: Text('Salary', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'water', child: Container(child: Text('Water', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'others', child: Container(child: Text('Other(s)', style: DropdownListStyle),)),  
  ];

  List<DropdownMenuItem<String>> othersItemList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'dj', child: Container(child: Text('DJ', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'live_band', child: Container(child: Text('Live band', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'transport', child: Container(child: Text('Transport', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'others', child: Container(child: Text('Other(s)', style: DropdownListStyle),)), 
  ];

  List<DropdownMenuItem<String>> toiletItemList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'air_refresher', child: Container(child: Text('Air refresher', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'soap', child: Container(child: Text('Soap', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'toilet_paper', child: Container(child: Text('Toilet paper', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'others', child: Container(child: Text('Other(s)', style: DropdownListStyle),)),  
  ];

  List<DropdownMenuItem<String>> emptyList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text('First select a category'),)),  
  ];

  List<DropdownMenuItem<String>> paymentStatusList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'paid', child: Container(child: Text('Paid', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'unpaid', child: Container(child: Text('Unpaid', style: DropdownListStyle),)),   
  ];

  List<DropdownMenuItem<String>> paymentMethodList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'card', child: Container(child: Text('Card', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'cash', child: Container(child: Text('Cash', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'mobile money', child: Container(child: Text('Mobile money', style: DropdownListStyle),)),  
  ];

List<DropdownMenuItem<String>> unitList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)),  
      DropdownMenuItem(value: 'Bottle', child: Container(child: Text('Bottle'),)),
      DropdownMenuItem(value: 'Kg', child: Container(child: Text('Kg', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'L', child: Container(child: Text('L', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'Pcs', child: Container(child: Text('Pcs', style: DropdownListStyle),)),  
  ];
  

  List<DropdownMenuItem<String>> incomeList = [
      DropdownMenuItem(value: 'none', child: Container(child: Text(''),)), 
      DropdownMenuItem(value: 'delivery_service', child: Container(child: Text('Delivery service', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'luggage', child: Container(child: Text('Luggage', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'freight', child: Container(child: Text('Freight', style: DropdownListStyle),)), 
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
      DropdownMenuItem(value: 'chevrolet', child: Container(child: Text('CHEVROLET', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'haval', child: Container(child: Text('HAVAL', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'hyundai', child: Container(child: Text('HYUNDAI', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'land rover', child: Container(child: Text('LAND ROVER', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'isuzu', child: Container(child: Text('ISUZU', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'kia', child: Container(child: Text('KIA', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'mercedes', child: Container(child: Text('MERCEDES', style: DropdownListStyle),)),
      DropdownMenuItem(value: 'nissan', child: Container(child: Text('NISSAN', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'peugeot', child: Container(child: Text('PEUGEOT', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'renault', child: Container(child: Text('RENAULT', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'suzuki', child: Container(child: Text('SUZUKI', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'toyota', child: Container(child: Text('TOYOTA', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'vw', child: Container(child: Text('VW', style: DropdownListStyle),)),
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
      DropdownMenuItem(value: 'angola', child: Container(child: Text('Angola', style: DropdownListStyle),)), 
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
      DropdownMenuItem(value: 'ivory_coast', child: Container(child: Text("Côte d'Ivoire", style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'djibouti', child: Container(child: Text('Djibouti', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'egypt', child: Container(child: Text('Egypt', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'equatorial_guinea', child: Container(child: Text('Equatorial Guinea', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'eritrea', child: Container(child: Text('Eritrea', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'eswatini', child: Container(child: Text('Eswatini', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'ethiopia', child: Container(child: Text('Ethiopia', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'gabon', child: Container(child: Text('Gabon', style: DropdownListStyle),)),   
      DropdownMenuItem(value: 'gambia', child: Container(child: Text('Gambia', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'ghana', child: Container(child: Text('Ghana', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'guinea', child: Container(child: Text('Guinea', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'guinea_bissau', child: Container(child: Text('Guinea-Bissau', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'kenya', child: Container(child: Text('Kenya', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'lesotho', child: Container(child: Text('Lesotho', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'liberia', child: Container(child: Text('Liberia', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'libya', child: Container(child: Text('Libya', style: DropdownListStyle),)),  
      DropdownMenuItem(value: 'madagascar', child: Container(child: Text('Madagascar', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'malawi', child: Container(child: Text('Malawi', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'mali', child: Container(child: Text('Mali', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'mauritania', child: Container(child: Text('Mauritania', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'mauritius', child: Container(child: Text('Mauritius', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'morocco', child: Container(child: Text('Morocco', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'mozambique', child: Container(child: Text('Mozambique', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'namibia', child: Container(child: Text('Namibia', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'niger', child: Container(child: Text('Niger', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'nigeria', child: Container(child: Text('Nigeria', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'rwanda', child: Container(child: Text('Rwanda', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'sao_tome', child: Container(child: Text('São Tomé and Príncipe', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'senegal', child: Container(child: Text('Senegal', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'seychelles', child: Container(child: Text('Seychelles', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'sierra_leone', child: Container(child: Text('Sierra Leone', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'somalia', child: Container(child: Text('Somalia', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'south_africa', child: Container(child: Text('South Africa', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'south_sudan', child: Container(child: Text('South Sudan', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'sudan', child: Container(child: Text('Sudan', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'tanzania', child: Container(child: Text('Tanzania', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'togo', child: Container(child: Text('Togo', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'tunisia', child: Container(child: Text('Tunisia', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'uganda', child: Container(child: Text('Uganda', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'zambia', child: Container(child: Text('Zambia', style: DropdownListStyle),)), 
      DropdownMenuItem(value: 'zimbabwe', child: Container(child: Text('Zimbabwe', style: DropdownListStyle),)),
        
  ];
}