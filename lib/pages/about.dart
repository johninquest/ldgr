import 'package:flutter/material.dart'; 
import 'package:rba/shared/bottom_nav_bar.dart';
import 'package:rba/styles/style.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About app', style: AppBarTitleStyle,), 
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text('rba', style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, letterSpacing: 2.0),),),
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text('rba is a simple bookkeeping app for bars and restaurants.', textAlign: TextAlign.center,),), 
              Container(
                margin: EdgeInsets.only(top: 100.0),
                child: Text('\u00A9 XYZ Ltd.'),)  
            ],
          ),),),
          bottomNavigationBar: BottomNavBar(), 
        
    );
  }
}