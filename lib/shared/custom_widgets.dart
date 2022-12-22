import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../utils/formatter.dart';
import '../utils/router.dart';
import '../styles/colors.dart';
import '../styles/style.dart';

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
        Column(children: [
          Text(Formatter().dbToUiDateTime(dateData)[0]),
          Text(Formatter().dbToUiDateTime(dateData)[1])
        ]),
        Text(Formatter().dbToUiValue(categoryData)),
        Container(child: Formatter().checkSplit2Words(sourceData)),
        Text('$amountData'),
      ]),
    );
  }
}

class EmptyTable extends StatelessWidget {
  const EmptyTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20.0, top: 50.0),
          child: Text(
            'No records found!',
            style: BodyStyle,
          ),
        ),
        Container(
            child: ElevatedButton(
                onPressed: () =>
                    PageRouter().navigateToPage(HomePage(), context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: myBlue,
                  padding: EdgeInsets.all(10.0),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.add,
                      size: 25.0,
                    ),
                  ],
                ))),
      ],
    );
  }
}
