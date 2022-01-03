import 'package:intl/intl.dart';

class ListFilterService {
  byDate(List filterList, String filterDate) {
    DateFormat targetFormat = DateFormat('yyyy-MM-dd');
    List filtered = [];
    for (var i in filterList) {
      if (i['created_at'] == filterDate) {
        filtered.add(i);
      }
    }
    return filtered;
  }

  byPeriod() {}

  byMonthAndYear(List filterList, int filterMonth, int filterYear) {
    List filtered = [];
    for (var i in filterList) {}
  }

  byCostArea() {}

  byPaymentStatus() {}
}
