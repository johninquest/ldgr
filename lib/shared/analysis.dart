import 'package:flutter/material.dart';
import 'package:tba/styles/colors.dart';
import 'package:tba/services/formatter.dart';

class SumTotalBoard extends StatelessWidget {
  // const RecordSummary({Key? key}) : super(key: key);
  final double expenditureSum;
  final double incomeSum;
  SumTotalBoard(this.expenditureSum, this.incomeSum);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.0),
      decoration: BoxDecoration(color: myYellow),
      height: 80.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'SUMMARY',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: myBlue),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    child: Text('EXPENDITURE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: myRed,
                            letterSpacing: 2.0)),
                  ),
                  Container(
                    child: Text(Formatter().toNoDecimal(expenditureSum),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: myBlue),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    child: Text('INCOME',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: myGreen,
                            letterSpacing: 2.0)),
                  ),
                  Container(
                    child: Text(Formatter().toNoDecimal(incomeSum),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: myBlue),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class SingleSumTotalBoard extends StatelessWidget {
  // const RecordSummary({Key? key}) : super(key: key);
  final String categoryType;
  SingleSumTotalBoard(this.categoryType);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.0),
      decoration: BoxDecoration(color: Colors.amber),
      height: 80.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              '$categoryType TOTAL',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue[900]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              '100 CFA',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue[900]),
            ),
          ),
        ],
      ),
    );
  }
}