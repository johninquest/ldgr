import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tba/styles/style.dart';

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
        case 'passengers':
          return 'Passengers';
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

  dbToUiDateTime(String? dbDateTime) {
    // print('Date data => $dbDateTime');
    if (dbDateTime != null && dbDateTime != '') {
      DateTime parsedDateTime = DateTime.parse(dbDateTime);
      DateFormat cmrDateFormat = DateFormat('dd/MM/yyyy');
      DateFormat cmrTimeFormat = DateFormat('HH:mm');
      String uiDate = cmrDateFormat.format(parsedDateTime);
      String uiTime = cmrTimeFormat.format(parsedDateTime);
      return [uiDate, uiTime];
    } else {
      return ['--/--/----', '--:--'];
    }
  }

  checkSplit2Words(String? twoWords) {
    if (twoWords != null) {
      var preFormat = dbToUiValue(twoWords);
      var twoWordsCheck = preFormat.contains(' ');
      if (twoWordsCheck == true) {
        List toArray = preFormat.split(' ');
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              toArray[0],
              style: TableItemStyle,
            ),
            Text(toArray[1], style: TableItemStyle)
          ],
        );
      } else if (twoWordsCheck == false) {
        return Text(
          preFormat,
          style: TableItemStyle,
          textAlign: TextAlign.center,
        );
      } else {
        return Text(twoWords);
      }
    }
  }

  toNoDecimal(num? amountInDouble) {
    if (amountInDouble != null && amountInDouble is double) {
      String amountAsStr = amountInDouble.toStringAsFixed(0);
      return amountAsStr;
    } else {
      return '0';
    }
  }

/*   toNoDecimalPlusCurrency(double amountInDouble) {
    print(amountInDouble);
    String amountAsStr = amountInDouble.toStringAsFixed(0);
    return 'XAF $amountAsStr';
  } */
}
