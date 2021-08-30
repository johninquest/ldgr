import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart';
import 'package:tba/services/formatter.dart';

class ErrorOccured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Text(
        'Ein Fehler ist aufgetreten.',
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue),
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
        'Alles ist gut.',
        style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    ));
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
        Text('DATE', style: ListTitleStyle,),
        Text('CATEGORY', style: ListTitleStyle,),
        Text('SOURCE', style: ListTitleStyle,),
        Text('AMOUNT', style: ListTitleStyle,),
      ]),
    );
  }
}

class ListItem extends StatelessWidget {
  final String dateData;
  final String categoryData;
  final String sourceData; 
  final String amountData;
  ListItem(this.dateData, this.categoryData, this.sourceData, this.amountData);

  // const ListTitle({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
        children: [
        Text(Formatter().dbToUiDate(dateData)),
        Text(Formatter().dbToUiValue(categoryData)),
        Text(Formatter().dbToUiValue(sourceData)),
        Text('$amountData'),
      ]),
    );
  }
}
