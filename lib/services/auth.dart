class AdminAuthService {
  verifyAdmin(String username, String password) {
    if (username == 'admin' && password == '#johnapps21') {
      return 'auth_success';
    } else {
      return 'auth_failed';
    }
  }
}
