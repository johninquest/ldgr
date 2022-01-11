import 'package:intl/intl.dart';

class ListFilterService {
  byString(List filterList, String targetStr) {
    List filtered = [];
    for (var i in filterList) {
      if (i['cost_area'] == targetStr ||
          i['item_category'] == targetStr ||
          i['item_name'] == targetStr ||
          i['entered_by'] == targetStr ||
          i['payment_method'] == targetStr ||
          i['payment_status'] == targetStr) {
        filtered.add(i);
      }
    }
    return filtered;
  }

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
