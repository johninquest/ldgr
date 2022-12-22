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

  commaToPeriod(String? decimalStr) {
    if (decimalStr == null) {
      return '';
    }
    if (decimalStr == '') {
      return '';
    } else {
      String _replaceCommaWithPeriod = decimalStr.replaceAll(',', '.');
      return _replaceCommaWithPeriod;
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

class CustomDelay {
  bySeconds(int delayTime) async {
    if (delayTime.runtimeType == int) {
      final dt = await Future.delayed(Duration(seconds: delayTime));
      return dt;
    }
  }
}

class Capitalize {
  word(String w) {
    String _capitalized = w[0].toUpperCase() + w.substring(1);
    return _capitalized;
  }
}

class AuthIdGenerator {
  fromName(String name) {
    String _trimedName = name.trim().toLowerCase();
    String _generatedId = _trimedName + '@rcl';
    return _generatedId;
  }
}
