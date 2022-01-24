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
    } else if (fDay != '' && fMonth != '' && fYear == '') {
      List filteredList = [];
      int toFilterDay = int.parse(fDay);
      int toFilterMonth = int.parse(fMonth);
      for (var i in fList) {
        int toCompareDay = DateTime.parse(i['picked_date']).day;
        int toCompareMonth = DateTime.parse(i['picked_date']).month;
        if (toCompareDay == toFilterDay && toCompareMonth == toFilterMonth) {
          filteredList.add(i);
        }
      }
      return filteredList;
    } else if (fDay != '' && fMonth == '' && fYear != '') {
      List filteredList = [];
      int toFilterDay = int.parse(fDay);
      int toFilterYear = int.parse(fYear);
      for (var i in fList) {
        int toCompareDay = DateTime.parse(i['picked_date']).day;
        int toCompareYear = DateTime.parse(i['picked_date']).year;
        if (toCompareDay == toFilterDay && toCompareYear == toFilterYear) {
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
    } else if (fDay == '' && fMonth != '' && fYear != '') {
      List filteredList = [];
      int toFilterMonth = int.parse(fMonth);
      int toFilterYear = int.parse(fYear);
      for (var i in fList) {
        int toCompareMonth = DateTime.parse(i['picked_date']).month;
        int toCompareYear = DateTime.parse(i['picked_date']).year;
        if (toCompareMonth == toFilterMonth && toCompareYear == toFilterYear) {
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

  byString(List fList, String targetStr) {
    List foundList = [];
    for (var i in fList) {
      String _costArea = i['cost_area'] ?? '';
      String _itemCategory = i['item_category'] ?? '';
      String _itemName = i['item_name'] ?? '';
      String _enteredBy = i['entered_by'];
      if (_costArea.toLowerCase().contains(targetStr) ||
          _itemCategory.toLowerCase().contains(targetStr) ||
          _itemName.toLowerCase().contains(targetStr) || 
          _enteredBy.toLowerCase().contains(targetStr)
          ) {
        foundList.add(i);
      }
    }
    return foundList;
  }
}
