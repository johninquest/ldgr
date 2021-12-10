import 'package:flutter/material.dart';

class SnackBarMessage {
  saveSuccess(context) {
    var message = ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Saved successfully \u{2713}')));
    return message;
  }

  saveFail(context) {
    var message = ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('An error occured!')));
    return message;
  }

  addSuccess(context) {
    var message = ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Added successfully \u{2713}')));
    return message;
  }

  updateSuccess(context) {
    var message = ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Updated successfully \u{2713}')));
    return message;
  }

  deleteSuccess(context) {
    var message = ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Deleted successfully \u{2713}')));
    return message;
  }

  underConstruction(context) {
    var message = ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Still under construction \u{1F6A7}')));
    return message;
  }

  generalErrorMessage(context) {
    var message = ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('An error occured!')));
    return message;
  } 

    customErrorMessage(String msg, context) {
    var message = ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
    return message;
  }
}
