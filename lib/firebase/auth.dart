import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  getCurrentUser() {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    print('Current firebase user =>  $firebaseUser');
  }
}