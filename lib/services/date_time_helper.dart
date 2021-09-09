import 'package:intl/intl.dart';

class DateTimeHelper {
  timestampForDB() {
    DateFormat dbDateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime dt = DateTime.now();
    String dtToString = dbDateTimeFormat.format(dt);
    return dtToString;
    // print(dtToString);
  }

  ageFromDate(String dateStr) {
    // String dateStr = '2001-09-11';
    // DateFormat InputFormat = DateFormat('dd/MM/yyyy');
    // var inputToDateTime = InputFormat.format(dateStr);
    DateTime parsedDateTime = DateTime.parse(dateStr);
    DateTime currentDateTime = DateTime.now();
    int diffInDays = currentDateTime.difference(parsedDateTime).inDays;
    String diffInYears = (diffInDays / 365).toStringAsFixed(0);
    return diffInYears;
  }
}
