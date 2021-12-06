import 'package:flutter/material.dart';

class AuthService {
  verifyAdmin(String username, String password) {
    if (username == 'admin' && password == '#johnapps21') {
      return 'auth_success';
    } else {
      return 'auth_failed';
    }
  }
}

class RoleBasedAccessControl {
  hideWidget(String? _role, Widget _widget) {
    if (_role == 'owner' || _role == 'manager') {
      return _widget;
    } else {
      return SizedBox();
    }
  }
}
