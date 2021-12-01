import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth fbAuth = FirebaseAuth.instance;

  loginUser(String _username, String _password) async {
    try {
      UserCredential authUser = await fbAuth.signInWithEmailAndPassword(
          email: _username, password: _password);
      return authUser.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        return null;
      }
    }
  }

  logoutUser() async {
    await fbAuth.signOut();
  }

  checkAuthStatus() {
    fbAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  getFbUser() {
    final fbUser = fbAuth.currentUser;
    // final fbUid = fbUser.uid;
    print('Current firebase auth =>  $fbAuth');
    print('Current firebase user =>  $fbUser');
    // print('Current firebase uid =>  $fbUid');
  }
}
