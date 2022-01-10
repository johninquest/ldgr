import 'package:intl/intl.dart';

class ListFilterService {
  byDate(List filterList, String filterDate) {
    // DateFormat targetFormat = DateFormat('yyyy-MM-dd');
    List filtered = [];
    for (var i in filterList) {
      if (i['picked_date'] == filterDate) {
        filtered.add(i);
      }
    }
    return filtered;
  }

  byPeriod() {}

  byMonthAndYear(List filterList, int filterMonth, int filterYear) {
    List filtered = [];
    for (var i in filterList) {
      int iMonth = DateTime.parse(i['picked_date']).month;
      int iYear = DateTime.parse(i['picked_date']).year;
      if (iMonth == filterMonth && iYear == filterYear) {
        filtered.add(i);
      }
    }
    return filtered;
  }

  byCostArea() {}

  byPaymentStatus() {}
}
