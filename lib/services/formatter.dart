import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ldgr/styles/style.dart';

class Formatter {
  dbToUiValue(String? dbValue) {
    if (dbValue != null) {
      switch (dbValue) {
        case 'bar':
          return 'Bar';
        case 'cleaning':
          return 'Cleaning';
        case 'kitchen':
          return 'Kitchen';
        case 'operating_costs':
        case 'operations':
          return 'Operations';
        case 'others':
          return 'Other(s)';
        case 'restaurant':
          return 'Restaurant';
        case 'toilet':
          return 'Toilet';
        default:
          return 'None';
      }
    } else {
      return '-';
    }
  }

  dbToUiDateTime(String? dbDateTime) {
    if (dbDateTime != null && dbDateTime != '') {
      DateTime parsedDateTime = DateTime.parse(dbDateTime);
      DateFormat fDateFormat = DateFormat('dd/MM/yyyy');
      DateFormat fTimeFormat = DateFormat('HH:mm');
      String uiDate = fDateFormat.format(parsedDateTime);
      String uiTime = fTimeFormat.format(parsedDateTime);
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
}

class DateTimeFormatter {
  toDateTimeStr() {}

  toDateString(DateTime? ts) {
    if (ts != null) {
      DateFormat toDateFormat = DateFormat('dd/MM/yyyy');
      String formatted = toDateFormat.format(ts);
      return formatted;
    } else {
      return '--/--/----';
    }
  }

  isoToUiDate(String dt) {
    if (DateTime.tryParse(dt) != null && dt != '') {
      DateTime parsedDatTime = DateTime.parse(dt);
      DateFormat cmrDateFormat = DateFormat('dd/MM/yyyy');
      String toCmrDateFormat = cmrDateFormat.format(parsedDatTime);
      return toCmrDateFormat;
    } else {
      return '--/--/----';
    }
  }

  toUiDateTime(String? dbDateTime) {
    if (dbDateTime != null && dbDateTime != '') {
      DateTime parsedDateTime = DateTime.parse(dbDateTime);
      DateFormat fDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm');
      String uiDateTime = fDateTimeFormat.format(parsedDateTime);
      return uiDateTime;
    } else {
      return '--/--/---- --:--';
    }
  }
}
