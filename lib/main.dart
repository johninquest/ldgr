import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ldgr/firebase/auth.dart';
import 'package:ldgr/pages/home.dart';
// import 'package:ldgr/pages/home.dart';
import 'package:ldgr/pages/inputs/login.dart';
import 'package:ldgr/styles/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeData myTheme = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme.copyWith(
        colorScheme: myTheme.colorScheme.copyWith(
          primary: myBlue,
          secondary: myBlue,
        ),
      ),
      home: LoginPage(), 
      // home: chooseStartPage(),
    );
  }
}

chooseStartPage() {
  FirebaseAuthService().fbAuth.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User not authenticated!');
      LoginPage();
    } else {
       print('User has been authenticated!');
      HomePage();
    }
  });
}
