import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart'; 
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../services/router.dart';
import 'input_expenditure.dart';
import 'input_income.dart';
// import 'all_records.dart';
import 'package:tba/pages/bottom_nav_bar.dart';

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
              child: Text('INCOME', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(primary: Colors.greenAccent)),)    
          ],
        ),
        ),
      // floatingActionButton: SideButtomMenu(), 
      bottomNavigationBar: BottomNavBar(), 
    );
  }
}
