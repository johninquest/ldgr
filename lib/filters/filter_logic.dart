class FilterService {
  byDate(List fList, String fDay, String fMonth, String fYear) {
    if (fDay != '' && fMonth != '' && fYear != '') {
      List filteredList = [];
      int toFilterDay = int.parse(fDay);
      int toFilterMonth = int.parse(fMonth);
      int toFilterYear = int.parse(fYear);
      for (var i in fList) {
        int toCompareDay = DateTime.parse(i['picked_date']).day;
        int toCompareMonth = DateTime.parse(i['picked_date']).month;
        int toCompareYear = DateTime.parse(i['picked_date']).year;
        if (toCompareDay == toFilterDay &&
            toCompareMonth == toFilterMonth &&
            toCompareYear == toFilterYear) {
          filteredList.add(i);
        }
      }
      return filteredList;
    } else if (fDay != '' && fMonth == '' && fYear == '') {
      List filteredList = [];
      int toFilterDay = int.parse(fDay);
      for (var i in fList) {
        int toCompareDay = DateTime.parse(i['picked_date']).day;
        if (toCompareDay == toFilterDay) {
          filteredList.add(i);
        }
      }
      return filteredList;
    } else if (fDay == '' && fMonth != '' && fYear == '') {
      List filteredList = [];
      int toFilterMonth = int.parse(fMonth);
      for (var i in fList) {
        int toCompareMonth = DateTime.parse(i['picked_date']).month;
        if (toCompareMonth == toFilterMonth) {
          filteredList.add(i);
        }
      }
      return filteredList;
    } else if (fDay == '' && fMonth == '' && fYear != '') {
      List filteredList = [];
      int toFilterYear = int.parse(fYear);
      for (var i in fList) {
        int toCompareYear = DateTime.parse(i['picked_date']).year;
        if (toCompareYear == toFilterYear) {
          filteredList.add(i);
        }
      }
      return filteredList;
    } else {
      return fList;
    }
  }
}
