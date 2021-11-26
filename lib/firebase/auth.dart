import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth fbAuth = FirebaseAuth.instance;

  getFbUser() {
    final fbUser = fbAuth.currentUser; 
    // final fbUid = fbUser.uid;
    print('Current firebase auth =>  $fbAuth'); 
    print('Current firebase user =>  $fbUser'); 
    // print('Current firebase uid =>  $fbUid');
  }
}
