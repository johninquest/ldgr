import 'package:flutter/material.dart';

class PageRouter {
  void navigateToPage(Widget widgetName, BuildContext widgetContext) {
    Navigator.of(widgetContext)
        .push(MaterialPageRoute(builder: (context) => widgetName));
  }
}
