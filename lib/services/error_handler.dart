class ErrorHandler {
  moneyInput(String amt) {
    if (num.tryParse(amt) != null) {
      return amt;
    } else {
      return '0';
    }
  }

  stringInput(String? value) {
    if (value == null) {
      return '';
    }
  }
}
