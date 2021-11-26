import 'package:flutter/material.dart';
import 'package:ldgr/pages/filters/filtered.dart'; 
import 'package:ldgr/styles/colors.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:ldgr/services/router.dart'; 

class FloatingSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.search_ellipsis,
      children: [
        SpeedDialChild(
            labelWidget: MyLabelWidget('Today', myLightRed),
            onTap: () => PageRouter().navigateToPage(Filtered(periodName: 'today'), context),
            ),
        SpeedDialChild(
            labelWidget: MyLabelWidget('Week', myBlueLighter),
            onTap: () => PageRouter().navigateToPage(Filtered(periodName: 'week'), context),
            ), 
        SpeedDialChild(
            labelWidget: MyLabelWidget('Month', myGreen),
            onTap: () => PageRouter().navigateToPage(Filtered(periodName: 'month'), context),
            ),  
        SpeedDialChild(
            labelWidget: MyLabelWidget('Year', myYellow),
            onTap: () => PageRouter().navigateToPage(Filtered(periodName: 'year'), context),
            ),            
        /* SpeedDialChild(
            labelWidget: MyLabelWidget('Expenditure', myRed),
            onTap: () => PageRouter().navigateToPage(ExpenditureRecords(), context),
            ), */
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
            letterSpacing: 2.0),
      ),
      decoration: BoxDecoration(
          color: myLabelBackgroundColor,
          borderRadius: BorderRadius.circular(5.0)),
    );
  }
}