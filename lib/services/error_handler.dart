class ErrorHandler {
  moneyInput(double? value) {
    if (value == null) {
      return 0;
    }
    if (value.runtimeType != double) {
      return 0;
    }
  }

  stringInput(String? value) {
    if (value == null) {
      return '';
    }
  }
}
