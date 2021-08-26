import 'package:intl/intl.dart';

class DateTimeHelper {
  timestampForDB() {
    DateFormat dbDateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime dt = DateTime.now();
    String dtToString = dbDateTimeFormat.format(dt);
    return dtToString;
    // print(dtToString);
  }
}
