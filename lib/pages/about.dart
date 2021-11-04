import 'package:flutter/material.dart'; 
import 'package:tba/shared/bottom_nav_bar.dart';
import 'package:tba/styles/style.dart';

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
                child: Text('phita', style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold),),),
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text('phita is a simple app designed to help transporters keep track of their finances and better manage their operations.', textAlign: TextAlign.center,),), 
              Container(
                margin: EdgeInsets.only(top: 100.0),
                child: Text('\u00A9 Phil Transport App'),)  
            ],
          ),),),
          bottomNavigationBar: BottomNavBar(), 
        
    );
  }
}