import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateTimeHelper {
  timestampForDB() {
    DateFormat dbDateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime dt = DateTime.now();
    String dtToString = dbDateTimeFormat.format(dt);
    return dtToString;
  }

  ageFromDate(DateTime pickedDate) {
    // String dateStr = '2001-09-11';
    // DateFormat InputFormat = DateFormat('dd/MM/yyyy');
    // var inputToDateTime = InputFormat.format(dateStr);
    // DateTime parsedDateTime = DateTime.parse(dateStr);
    DateTime currentDateTime = DateTime.now();
    int diffInDays = currentDateTime.difference(pickedDate).inDays;
    String diffInYears = (diffInDays / 365).toStringAsFixed(0);
    return diffInYears;
  }

  ageFromDateStr(String? storedDate) {
    if (storedDate != null && storedDate != '') {
      DateTime parsedDateTime = DateTime.parse(storedDate);
      DateTime currentDateTime = DateTime.now();
      int diffInDays = currentDateTime.difference(parsedDateTime).inDays;
      String diffInYears = (diffInDays / 365).toStringAsFixed(0);
      return diffInYears;
    } else {
      return '0';
    }
  }

  dateInWords(DateTime? dt) {
    if (dt != null) {
      initializeDateFormatting();
      String displayedDate = DateFormat.yMMMMEEEEd('en').format(dt);
      return displayedDate;
    } else {
      return 'Date not available';
    }
  }

  toDbDateTimeFormat(String? inputDateStr) {
    if (inputDateStr != null && inputDateStr != '') {
      DateTime inputToDateTime = DateFormat('dd/MM/yyyy').parse(inputDateStr);
      String toDbFormat =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(inputToDateTime);
      return toDbFormat;
    } else {
      return '0000-00-00 00:00:00';
    }
  }

  timestampAsString(DateTime datetime) {
    DateFormat dbDateTimeFormat = DateFormat('yyMMddHHmmss');
    DateTime dt = DateTime.now();
    String dtToString = dbDateTimeFormat.format(dt);
    return dtToString;
  }

  currentYear(DateTime now) {
    String yearToString = DateFormat('yyyy').format(now);
    return yearToString;
  }
}
