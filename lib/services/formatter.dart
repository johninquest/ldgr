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
      String uiDate = cmrDateFormat.format(parsedDateTime);
      return uiDate;
    } else {
      return '--/--/----';
    }
  }
}
