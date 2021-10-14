import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart'; 
import 'package:tba/styles/colors.dart';
import 'package:tba/services/router.dart';
import 'package:tba/pages/inputs/expenditure.dart';
import 'package:tba/pages/inputs/income.dart';
import 'package:tba/shared/side_menu.dart';
import 'package:tba/shared/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('transpota', style: PageHeaderStyle,), 
        centerTitle: true, 
      ),
      drawer: SideMenu(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 50.0), 
              child: Text('The management app for transporters', style: BodyStyle,),),
          Container(
            height: 80.0, 
            width: 200.0, 
            margin: EdgeInsets.only(bottom: 25.0),
            child: ElevatedButton(
              onPressed: () => PageRouter().navigateToPage(InputExpenditurePage(), context), 
              child: Text('EXPENDITURE', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),), 
              style: ElevatedButton.styleFrom(primary: myRed),),), 
           Container(
             height: 80.0, 
             width: 200.0, 
             margin: EdgeInsets.only(bottom: 25.0),
            child: ElevatedButton(
              onPressed: () => PageRouter().navigateToPage(InputIncomePage(), context), 
              child: Text('INCOME', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)), style: ElevatedButton.styleFrom(primary: myGreen)),),
          ],
        ),
        ),
      bottomNavigationBar: BottomNavBar(), 
    );
  }
}
