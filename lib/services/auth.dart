class AdminAuthService {
  verifyAdmin(String username, String password) {
    if (username == 'admin' && password == '#johnapps21') {
      return 'auth_success';
    } else {
      return 'auth_failed';
    }
  }

  rbacCheck(String role) {
    if (role == 'owner') {
      print('Owner => $role');
    }
    if (role == 'manager') {
      print('Manager => $role');
    }
    if (role == 'employee') {
      print('Employee => $role');
    }
  }
}
