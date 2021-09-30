import 'dart:convert';

class InputHandler {
  moneyCheck(String amt) {
    if (num.tryParse(amt) != null) {
      return amt;
    } else {
      return '0';
    }
  }

  stringCheck(String? value) {
    if (value == null) {
      return '';
    }
  }
}

class DataParser {
  strToMap(String? myStr) {
    if (myStr != null) {
      Map toMap = jsonDecode(myStr);
      return toMap;
    }
  }

  mapToStr(Map? myMap) {
    if (myMap != null) {
      String toStr = jsonEncode(myMap);
      return toStr;
    }
  }
}
