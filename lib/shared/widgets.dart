import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart';
import 'package:tba/styles/colors.dart';
import 'package:tba/services/formatter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tba/services/router.dart';
import 'package:tba/pages/records/income.dart';
import 'package:tba/pages/records/expenditure.dart';
// import 'package:tba/pages/all_records.dart';

class ErrorOccured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text(
        'An error has occured!',
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: myBlue),
      ),
    ));
  }
}

class WaitingForResponse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class NoErrorOccured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text(
        'What a beautiful day!',
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: myBlue),
      ),
    ));
  }
}

class SideButtomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      children: [
        SpeedDialChild(
            labelWidget: MyLabelWidget('Expenditure', myRed),
            onTap: () => PageRouter().navigateToPage(ExpenditureRecords(), context),
            // onTap: () => print('Pressed expenses button!')
            ),
        SpeedDialChild(
            labelWidget: MyLabelWidget('Income', myGreen),
            onTap: () => PageRouter().navigateToPage(IncomeRecords(), context),
            ),
       /*  SpeedDialChild(
            labelWidget: MyLabelWidget('Old records', Colors.blueGrey),
            onTap: () => PageRouter().navigateToPage(AllRecordsPage(), context),
            ),     */
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

class ListTitle extends StatelessWidget {
  // const ListTitle({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      height: 40.0,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'DATE',
          style: ListTitleStyle,
        ),
        Text(
          'CATEGORY',
          style: ListTitleStyle,
        ),
        Text(
          'SOURCE',
          style: ListTitleStyle,
        ),
        Text(
          'AMOUNT',
          style: ListTitleStyle,
        ),
      ]),
    );
  }
}

class ListItem extends StatelessWidget {
  final String dateData;
  final String categoryData;
  final String sourceData;
  final double amountData;
  ListItem(this.dateData, this.categoryData, this.sourceData, this.amountData);

  // const ListTitle({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Formatter().checkSplit2Words(sourceData);
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      height: 40.0,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(children: [Text(Formatter().dbToUiDateTime(dateData)[0]), Text(Formatter().dbToUiDateTime(dateData)[1])]),
        Text(Formatter().dbToUiValue(categoryData)),
        Container(child: Formatter().checkSplit2Words(sourceData)),
        Text('$amountData'),
      ]),
    );
  }
}
