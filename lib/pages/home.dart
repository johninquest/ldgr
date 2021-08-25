import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart'; 
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../services/router.dart';
import 'input_expenditure.dart';
import 'input_income.dart';
import 'all_records.dart';

class HomePage extends StatelessWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MotoBusiness', style: PageHeaderStyle,), 
        centerTitle: true,
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
      floatingActionButton: SideButtomMenu(),  
      
    );
  }
}

class SideButtomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      children: [
        SpeedDialChild(
          labelWidget: MyLabelWidget('Expenditure', Colors.redAccent),
          onTap: () => PageRouter().navigateToPage(InputExpenditurePage(), context),
          // onTap: () => print('Pressed expenses button!')
        ),
        SpeedDialChild(
            labelWidget: MyLabelWidget('Income', Colors.greenAccent),
            // onTap: () => print('Pressed income button!') 
            onTap: () => PageRouter().navigateToPage(InputIncomePage(), context),
            ), 
        SpeedDialChild(
            labelWidget: MyLabelWidget('Records', Colors.black),
            // onTap: () => print('Pressed income button!') 
            onTap: () => PageRouter().navigateToPage(AllRecordsPage(), context),
            ),    
      ],
    );
  }
}

class MyLabelWidget extends StatelessWidget {
  final String myLabelName;
  final Color myLabelBackgroundColor;
  MyLabelWidget(this.myLabelName, this.myLabelBackgroundColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: Text(
        myLabelName,
        style: TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.0),
      ),
      decoration: BoxDecoration(
          color: myLabelBackgroundColor,
          borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
