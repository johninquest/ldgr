import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Formatter {
  dbToUiValue(String? dbValue) {
    if (dbValue != null) {
      switch (dbValue) {
        case 'car_maintenance':
          return 'Car maintenance';
        // break;
        case 'car_repairs':
          return 'Car repairs';
        case 'delivery_service':
          return 'Delivery service';
        case 'drinks':
          return 'Drinks';
        case 'expenditure':
          return 'Expenditure';
        case 'food':
          return 'Food';
        case 'fuel':
          return 'Fuel';
        case 'income':
          return 'Income';
        case 'luggage':
          return 'Luggage';
        case 'others':
          return 'Other(s)';
        case 'none':
          return 'None';
        case 'park_fees':
          return 'Park fees';
        case 'police_controls':
          return 'Police controls';
        case 'tollgate_fees':
          return 'Tollgate fees';
        default:
          return 'None';
      }
    } else {
      return '-';
    }
  }

  dbToUiDate(String? dbDateTime) {
    if (dbDateTime != null) {
      DateTime parsedDateTime = DateTime.parse(dbDateTime);
      DateFormat cmrDateFormat = DateFormat('dd/MM/yyyy');
      DateFormat cmrTimeFormat = DateFormat('hh:mm');
      String uiDate = cmrDateFormat.format(parsedDateTime);
      String uiTime = cmrTimeFormat.format(parsedDateTime);
      return [uiDate, uiTime];
    } else {
      return '--/--/----';
    }
  }

  checkSplit2Words(String? twoWords) {
    if (twoWords != null) {
      var preFormat = dbToUiValue(twoWords);
      // print(preFormat);
      var twoWordsCheck = preFormat.contains(' ');
      // print(twoWordsCheck);
     if (twoWordsCheck == true) {
        List toArray = preFormat.split(' ');
        // print(toArray);
         return Column(
          // mainAxisAlignment: MainAxisAlignment.center, 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text(toArray[0]), Text(toArray[1])],
        );
      } 
      else if (twoWordsCheck == false) {
        return Text(preFormat, textAlign: TextAlign.center,);
      } else {
        return Text(twoWords);
      }
    }
  }
}
