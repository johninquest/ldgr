import 'package:flutter/material.dart';
import 'package:rba/pages/home.dart';
import 'package:rba/styles/colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: myBlue,
        accentColor: myBlue,
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity, 
      ),
      home: HomePage(),
    );
  }
}
