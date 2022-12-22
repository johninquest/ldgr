import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/login.dart';
import 'styles/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData myTheme = ThemeData(
        colorSchemeSeed: primaryColor,
        /* brightness: Brightness.light, */
        useMaterial3: true,
        // fontFamily: 'Lato',
        textTheme: GoogleFonts.latoTextTheme());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: myTheme,
      // darkTheme: ThemeData.dark(),
      home: LoginPage(),
    );
  }
}
