import 'package:flutter/material.dart';
import 'package:ldgr/styles/colors.dart';
import 'package:ldgr/services/formatter.dart';
import 'package:ldgr/services/currency.dart';

class SumTotalBoard extends StatelessWidget {
  // const RecordSummary({Key? key}) : super(key: key);
  final num expenditureSum;
  final num incomeSum;
  final String curCountry;
  SumTotalBoard(this.expenditureSum, this.incomeSum, this.curCountry);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.95,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 1.0),
      decoration: BoxDecoration(color: myYellow),
      height: 90.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'OVERALL BALANCE',
              style: TextStyle(fontWeight: FontWeight.bold, color: myBlue),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 1.0),
                    child: Text('EXPENDITURE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: myRed,
                            letterSpacing: 2.0)),
                  ),
                  Container(
                    child: Text(
                      '${CurrencyHandler().fromCountry(curCountry)} ${Formatter().toNoDecimal(expenditureSum)}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: myBlue),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 1.0),
                    child: Text('INCOME',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: myTeal,
                            letterSpacing: 2.0)),
                  ),
                  Container(
                    child: Text(
                      '${CurrencyHandler().fromCountry(curCountry)} ${Formatter().toNoDecimal(incomeSum)}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: myBlue),
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

class BalanceByPeriod extends StatelessWidget {
  // const RecordSummary({Key? key}) : super(key: key);
  final num expenditureSum;
  final num incomeSum;
    final String balancePeriod;
  final String setCurrency;
  BalanceByPeriod(this.expenditureSum, this.incomeSum, this.balancePeriod, this.setCurrency);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 1.0),
      decoration: BoxDecoration(color: myYellow),
      height: 90.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Text(
              balanceTitle(balancePeriod),
              style: TextStyle(fontWeight: FontWeight.bold, color: myBlue),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 1.0),
                    child: Text('EXPENDITURE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: myRed,
                            letterSpacing: 2.0)),
                  ),
                  Container(
                    child: Text(
                      '$setCurrency ${Formatter().toNoDecimal(expenditureSum)}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: myBlue),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 1.0),
                    child: Text('INCOME',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: myTeal,
                            letterSpacing: 2.0)),
                  ),
                  Container(
                    child: Text(
                      '$setCurrency ${Formatter().toNoDecimal(incomeSum)}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: myBlue),
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

  balanceTitle(String period) {
    if (period == 'today') {
      return '''today's balance'''.toUpperCase();
    }
    if (period == 'week') {
      return '''this week's balance'''.toUpperCase();
    }
    if (period == 'month') {
      return '''this month's balance'''.toUpperCase();
    }
    if (period == 'year') {
      return '''this year's balance'''.toUpperCase();
    }
  }
}
