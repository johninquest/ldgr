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
