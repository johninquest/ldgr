import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart'; 
import '../services/router.dart';
import 'package:tba/pages/inputs/expenditure.dart';
import 'package:tba/pages/inputs/income.dart';
import 'package:tba/pages/inputs/vehicle.dart';
import 'package:tba/pages/bottom_nav_bar.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatelessWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRANSPOTA', style: PageHeaderStyle,), 
        centerTitle: true, 
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50.0),
          child: Text('A simple bookkeeping app for transporters', style: BodyStyle,),),
          Container(
            height: 80.0, 
            width: 200.0, 
            margin: EdgeInsets.only(bottom: 25.0),
            child: ElevatedButton(
              onPressed: () => PageRouter().navigateToPage(InputExpenditurePage(), context), 
              child: Text('EXPENDITURE', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),), 
              style: ElevatedButton.styleFrom(primary: Colors.redAccent),),), 
           Container(
             height: 80.0, 
             width: 200.0, 
             margin: EdgeInsets.only(bottom: 25.0),
            child: ElevatedButton(
              onPressed: () => PageRouter().navigateToPage(InputIncomePage(), context), 
              child: Text('INCOME', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(primary: Colors.greenAccent)),),
            Container(
             height: 50.0, 
             width: 200.0, 
             margin: EdgeInsets.only(bottom: 25.0),
            child: ElevatedButton(
              onPressed: () => PageRouter().navigateToPage(InputVehiclePage(), context), 
              child: Text('vehicle', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(primary: Colors.brown[300])),)          
          ],
        ),
        ),
      // floatingActionButton: SideButtomMenu(), 
      bottomNavigationBar: BottomNavBar(), 
    );
  }
}
