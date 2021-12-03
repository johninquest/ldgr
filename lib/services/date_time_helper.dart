import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateTimeHelper {
  timestampForDB(DateTime dt) {
    // DateTime dt = DateTime.now();
    DateFormat dbDateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    String dtToString = dbDateTimeFormat.format(dt);
    return dtToString;
  }

  ageFromDate(DateTime pickedDate) {
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
