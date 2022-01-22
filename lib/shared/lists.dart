import 'package:flutter/material.dart';
import 'package:ldgr/styles/colors.dart';
import 'package:ldgr/styles/style.dart';

class MyItemList {
  List<DropdownMenuItem<String>> accountList = [
    DropdownMenuItem(
        value: '',
        child: Container(
          child: Text(''),
        )),
    DropdownMenuItem(
        value: 'expense',
        child: Container(
          child: Text('Expense'),
        )),
    DropdownMenuItem(
        value: 'income',
        child: Container(
          child: Text('Income', style: DropdownListStyle),
        )),
  ];

  List<DropdownMenuItem<String>> businessTypeList = [
    DropdownMenuItem(
        value: 'none',
        child: Container(
          child: Text(''),
        )),
    DropdownMenuItem(
        value: 'bar',
        child: Container(
          child: Text('Bar', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'cafe',
        child: Container(
          child: Text('Café', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'restaurant',
        child: Container(
          child: Text('Restaurant', style: DropdownListStyle),
        )),
  ];

  List<DropdownMenuItem<String>> costAreaList = [
    DropdownMenuItem(
        value: '',
        child: Container(
          child: Text(''),
        )),
    DropdownMenuItem(
        value: 'bar',
        child: Container(
          child: Text('Bar', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'cleaning',
        child: Container(
          child: Text('Cleaning', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'kitchen',
        child: Container(
          child: Text('Kitchen', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'operation',
        child: Container(
          child: Text('Operation', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'others',
        child: Container(
          child: Text('Other(s)', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'restaurant',
        child: Container(
          child: Text('Restaurant', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'toilet',
        child: Container(
          child: Text('Toilet', style: DropdownListStyle),
        )),
  ];

  List<DropdownMenuItem<String>> emptyList = [
    DropdownMenuItem(
        value: 'none',
        child: Container(
          child: Text('First select a category'),
        )),
  ];

  List<DropdownMenuItem<String>> paymentStatusList = [
    DropdownMenuItem(
        value: '',
        child: Container(
          child: Text(''),
        )),
    DropdownMenuItem(
        value: 'paid',
        child: Container(
          child: Text('Paid', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'unpaid',
        child: Container(
          child: Text('Unpaid', style: DropdownListStyle),
        )),
  ];

  List<DropdownMenuItem<String>> paymentMethodList = [
    DropdownMenuItem(
        value: '',
        child: Container(
          child: Text(''),
        )),
    DropdownMenuItem(
        value: 'card',
        child: Container(
          child: Text('Card', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'cash',
        child: Container(
          child: Text('Cash', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'mobile money',
        child: Container(
          child: Text('Mobile money', style: DropdownListStyle),
        )),
  ];

  List<DropdownMenuItem<String>> unitList = [
    DropdownMenuItem(
        value: '',
        child: Container(
          child: Text(''),
        )),
    DropdownMenuItem(
        value: 'bottle',
        child: Container(
          child: Text('Bottle'),
        )), 
    DropdownMenuItem(
        value: 'box',
        child: Container(
          child: Text('Box'),
        )),    
    DropdownMenuItem(
        value: 'crate',
        child: Container(
          child: Text('Crate'),
        )), 
    DropdownMenuItem(
        value: 'g',
        child: Container(
          child: Text('g', style: DropdownListStyle),
        )),        
    DropdownMenuItem(
        value: 'kg',
        child: Container(
          child: Text('Kg', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'l',
        child: Container(
          child: Text('L', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'pcs',
        child: Container(
          child: Text('Pcs', style: DropdownListStyle),
        )),
  ];

  // Inventory options
    List<DropdownMenuItem<String>> storeOptionsList = [
    DropdownMenuItem(
        value: 'add',
        child: Container(
          child: Text('Add to stock', style: TextStyle(color: myGreen),),
        )),
    DropdownMenuItem(
        value: 'remove',
        child: Container(
          child: Text('Remove from stock', style: TextStyle(color: myRed),),
        )),
  ];

  List<DropdownMenuItem<String>> countryList = [
    DropdownMenuItem(
        value: 'none',
        child: Container(
          child: Text(''),
        )),
    DropdownMenuItem(
        value: 'algeria',
        child: Container(
          child: Text('Algeria', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'angola',
        child: Container(
          child: Text('Angola', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'benin',
        child: Container(
          child: Text('Benin', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'botswana',
        child: Container(
          child: Text('Botswana', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'burkina_faso',
        child: Container(
          child: Text('Burkina Faso', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'burundi',
        child: Container(
          child: Text('Burundi', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'cabo verde',
        child: Container(
          child: Text('Cabo Verde', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'cameroon',
        child: Container(
          child: Text('Cameroon', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'central_african_republic',
        child: Container(
          child: Text('Central African Republic', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'chad',
        child: Container(
          child: Text('Chad', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'comoros',
        child: Container(
          child: Text('Comoros', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'congo_drc',
        child: Container(
          child: Text('Congo, DRC', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'congo_republic',
        child: Container(
          child: Text('Congo, Republic', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'ivory_coast',
        child: Container(
          child: Text("Côte d'Ivoire", style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'djibouti',
        child: Container(
          child: Text('Djibouti', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'egypt',
        child: Container(
          child: Text('Egypt', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'equatorial_guinea',
        child: Container(
          child: Text('Equatorial Guinea', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'eritrea',
        child: Container(
          child: Text('Eritrea', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'eswatini',
        child: Container(
          child: Text('Eswatini', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'ethiopia',
        child: Container(
          child: Text('Ethiopia', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'gabon',
        child: Container(
          child: Text('Gabon', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'gambia',
        child: Container(
          child: Text('Gambia', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'ghana',
        child: Container(
          child: Text('Ghana', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'guinea',
        child: Container(
          child: Text('Guinea', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'guinea_bissau',
        child: Container(
          child: Text('Guinea-Bissau', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'kenya',
        child: Container(
          child: Text('Kenya', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'lesotho',
        child: Container(
          child: Text('Lesotho', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'liberia',
        child: Container(
          child: Text('Liberia', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'libya',
        child: Container(
          child: Text('Libya', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'madagascar',
        child: Container(
          child: Text('Madagascar', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'malawi',
        child: Container(
          child: Text('Malawi', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'mali',
        child: Container(
          child: Text('Mali', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'mauritania',
        child: Container(
          child: Text('Mauritania', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'mauritius',
        child: Container(
          child: Text('Mauritius', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'morocco',
        child: Container(
          child: Text('Morocco', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'mozambique',
        child: Container(
          child: Text('Mozambique', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'namibia',
        child: Container(
          child: Text('Namibia', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'niger',
        child: Container(
          child: Text('Niger', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'nigeria',
        child: Container(
          child: Text('Nigeria', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'rwanda',
        child: Container(
          child: Text('Rwanda', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'sao_tome',
        child: Container(
          child: Text('São Tomé and Príncipe', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'senegal',
        child: Container(
          child: Text('Senegal', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'seychelles',
        child: Container(
          child: Text('Seychelles', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'sierra_leone',
        child: Container(
          child: Text('Sierra Leone', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'somalia',
        child: Container(
          child: Text('Somalia', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'south_africa',
        child: Container(
          child: Text('South Africa', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'south_sudan',
        child: Container(
          child: Text('South Sudan', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'sudan',
        child: Container(
          child: Text('Sudan', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'tanzania',
        child: Container(
          child: Text('Tanzania', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'togo',
        child: Container(
          child: Text('Togo', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'tunisia',
        child: Container(
          child: Text('Tunisia', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'uganda',
        child: Container(
          child: Text('Uganda', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'zambia',
        child: Container(
          child: Text('Zambia', style: DropdownListStyle),
        )),
    DropdownMenuItem(
        value: 'zimbabwe',
        child: Container(
          child: Text('Zimbabwe', style: DropdownListStyle),
        )),
  ];
}
