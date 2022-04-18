import 'package:flutter/material.dart';
import 'package:ldgr/pages/analysis/filters.dart';

import '../../styles/colors.dart';

class AnalysisTable extends StatelessWidget {
  final List daybookData;
  const AnalysisTable({Key? key, required this.daybookData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _filter = AnalysisFilters();
    return Table(
      children: [
        TableRow(children: [
          TableCell(
              child: Container(
            margin: EdgeInsets.only(bottom: 1.0, top: 1.0, right: 2.0),
            color: myBlue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                  child: Text(
                    'Total',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                  child: Text(
                    "${_filter.getSum(daybookData)}",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )),
          TableDataBox(
            boxTitle: 'Paid',
            boxData: "${_filter.getSumByPaidStatus(daybookData, 'paid')}",
            boxColor: myGreen,
          ),
          TableDataBox(
            boxTitle: 'Unpaid',
            boxData: "${_filter.getSumByPaidStatus(daybookData, 'unpaid')}",
            boxColor: myAmber,
          ),
        ]),
        TableRow(children: [
          TableDataBox(
            boxTitle: '',
            boxData: 'Bar',
            boxColor: Colors.white,
          ),
          TableDataBox(
            boxTitle: '',
            boxData:
                "${_filter.getSumByPaidStatusAndCostArea(daybookData, 'paid', 'bar')}",
            boxColor: myGreen,
          ),
          TableDataBox(
            boxTitle: '',
            boxData:
                "${_filter.getSumByPaidStatusAndCostArea(daybookData, 'unpaid', 'bar')}",
            boxColor: myAmber,
          ),
        ]),
        TableRow(children: [
          TableDataBox(
            boxTitle: '',
            boxData: 'Cleaning',
            boxColor: Colors.white,
          ),
          TableDataBox(
            boxTitle: '',
            boxData:
                "${_filter.getSumByPaidStatusAndCostArea(daybookData, 'paid', 'cleaning')}",
            boxColor: myGreen,
          ),
          TableDataBox(
            boxTitle: '',
            boxData:
                "${_filter.getSumByPaidStatusAndCostArea(daybookData, 'unpaid', 'cleaning')}",
            boxColor: myAmber,
          ),
        ]),
        TableRow(children: [
          TableDataBox(
            boxTitle: '',
            boxData: 'Kitchen',
            boxColor: Colors.white,
          ),
          TableDataBox(
            boxTitle: '',
            boxData:
                "${_filter.getSumByPaidStatusAndCostArea(daybookData, 'paid', 'kitchen')}",
            boxColor: myGreen,
          ),
          TableDataBox(
            boxTitle: '',
            boxData:
                "${_filter.getSumByPaidStatusAndCostArea(daybookData, 'unpaid', 'kitchen')}",
            boxColor: myAmber,
          ),
        ]),
        TableRow(children: [
          TableDataBox(
            boxTitle: '',
            boxData: 'Operations',
            boxColor: Colors.white,
          ),
          TableDataBox(
            boxTitle: '',
            boxData:
                "${_filter.getSumByPaidStatusAndCostArea(daybookData, 'paid', 'operation')}",
            boxColor: myGreen,
          ),
          TableDataBox(
            boxTitle: '',
            boxData:
                "${_filter.getSumByPaidStatusAndCostArea(daybookData, 'unpaid', 'operation')}",
            boxColor: myAmber,
          ),
        ]),
        TableRow(children: [
          TableDataBox(
            boxTitle: '',
            boxData: 'Other(s)',
            boxColor: Colors.white,
          ),
          TableDataBox(
            boxTitle: '',
            boxData:
                "${_filter.getSumByPaidStatusAndCostArea(daybookData, 'paid', 'others')}",
            boxColor: myGreen,
          ),
          TableDataBox(
            boxTitle: '',
            boxData:
                "${_filter.getSumByPaidStatusAndCostArea(daybookData, 'unpaid', 'others')}",
            boxColor: myAmber,
          ),
        ]),
        TableRow(children: [
          TableDataBox(
            boxTitle: '',
            boxData: 'Toilet',
            boxColor: Colors.white,
          ),
          TableDataBox(
            boxTitle: '',
            boxData:
                "${_filter.getSumByPaidStatusAndCostArea(daybookData, 'paid', 'toilet')}",
            boxColor: myGreen,
          ),
          TableDataBox(
            boxTitle: '',
            boxData:
                "${_filter.getSumByPaidStatusAndCostArea(daybookData, 'unpaid', 'toilet')}",
            boxColor: myAmber,
          ),
        ]),
      ],
    );
  }
}

class TableDataBox extends StatelessWidget {
  final String boxTitle;
  final String boxData;
  final Color boxColor;
  const TableDataBox(
      {Key? key,
      required this.boxTitle,
      required this.boxData,
      required this.boxColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        margin: EdgeInsets.only(bottom: 1.0, top: 1.0, left: 3.0, right: 3.0),
        decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.all(Radius.circular(0.0))),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
              child: Text(
                boxTitle,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
              child: Text(boxData),
            ),
          ],
        ),
      ),
    );
  }
}
