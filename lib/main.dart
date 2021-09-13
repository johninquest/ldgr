import 'package:flutter/material.dart';
import 'package:tba/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        accentColor: Colors.blue[900],
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity, 
      ),
      home: HomePage(),
    );
  }
}
