import 'package:flutter/material.dart'; 
// import 'package:tba/styles/style.dart';
import 'package:tba/styles/colors.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tba/services/router.dart'; 
import 'package:tba/pages/records/income.dart';
import 'package:tba/pages/records/expenditure.dart';
import 'package:tba/pages/filters/overview.dart';

class FloatingSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.ellipsis_search,
      children: [
        SpeedDialChild(
            labelWidget: MyLabelWidget('Expenditure', myRed),
            onTap: () => PageRouter().navigateToPage(ExpenditureRecords(), context),
            ),
        SpeedDialChild(
            labelWidget: MyLabelWidget('Income', myGreen),
            onTap: () => PageRouter().navigateToPage(IncomeRecords(), context),
            ),
       SpeedDialChild(
            labelWidget: MyLabelWidget('Filters', myBlue),
            onTap: () => PageRouter().navigateToPage(FilterOverview(), context),
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
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.0),
      ),
      decoration: BoxDecoration(
          color: myLabelBackgroundColor,
          borderRadius: BorderRadius.circular(5.0)),
    );
  }
}