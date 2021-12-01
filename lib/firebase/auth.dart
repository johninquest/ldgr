import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth fbAuth = FirebaseAuth.instance;

  loginUser(String _username, String _password) async {
    print('Username => $_username');
    print('Password => $_password');
    try {
      UserCredential authUser = await fbAuth.signInWithEmailAndPassword(
          email: _username, password: _password);
      // print('Authenticated user => ${authUser.user}');
      // print('//////////////////////////////////////////');
      fbAuth.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
        } else {
          print('User is signed in!');
        }
      });
      /* print('Authenticated user uid => ${authUser.user!.uid}');
      print('Response type => ${authUser.runtimeType}'); */

      return authUser.user!.email;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'User not found!') {
        print('No user found for that email.');
      } else if (e.code == 'Wrong password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  logoutUser() async {
    await fbAuth.signOut();
  } 

  checkAuthStatus() {}


  getFbUser() {
    final fbUser = fbAuth.currentUser;
    // final fbUid = fbUser.uid;
    print('Current firebase auth =>  $fbAuth');
    print('Current firebase user =>  $fbUser');
    // print('Current firebase uid =>  $fbUid');
  }
}
