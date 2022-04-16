import 'package:flutter/material.dart';
import 'package:ldgr/filters/filter_data.dart';
import 'package:ldgr/filters/filter_logic.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/pages/analysis/barchart.dart';
import 'package:ldgr/pages/analysis/chart_data_models.dart';
import 'package:ldgr/pages/analysis/piechart.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/shared/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _fsQuery = FirestoreService().getSubCollection('records', 'daybook');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Analysis'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _fsQuery,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorOccured();
            }
            if (snapshot.hasData) {
              List resData = snapshot.data as List;
              return AnalysisDashboard(fsData: resData);
            } else {
              return WaitingForResponse();
            }
          }),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class AnalysisDashboard extends StatefulWidget {
  final List fsData;
  const AnalysisDashboard({Key? key, required this.fsData}) : super(key: key);

  @override
  _AnalysisDashboardState createState() => _AnalysisDashboardState();
}

class _AnalysisDashboardState extends State<AnalysisDashboard> {
  String? _day;
  String? _month;
  String? _year;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Object>>? _dayList = FilterData().dayList();
    List<DropdownMenuItem<Object>>? _monthList = FilterData().monthList();
    List<DropdownMenuItem<Object>>? _yearList = FilterData().yearList();
    // final resData = widget.fsData;
    final resData = FilterService()
        .byDate(widget.fsData, _day ?? '', _month ?? '', _year ?? '');
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'DD', labelStyle: TextStyle(fontSize: 12.0)),
                    items: _dayList,
                    validator: (val) => val == null ? 'DD?' : null,
                    onChanged: (val) {
                      setState(() {
                        _day = val as String?;
                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'MM', labelStyle: TextStyle(fontSize: 12.0)),
                    items: _monthList,
                    validator: (val) => val == null ? 'MM?' : null,
                    onChanged: (val) => setState(() {
                      _month = val as String?;
                    }),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                  margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        labelText: 'YYYY',
                        labelStyle: TextStyle(fontSize: 12.0)),
                    items: _yearList,
                    validator: (val) => val == null ? 'YYYY?' : null,
                    onChanged: (val) => setState(() {
                      _year = val as String?;
                    }),
                  ),
                ),
              ],
            ),
          ),
         
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 3.0),
            padding: EdgeInsets.all(3.0),
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.width * 0.45,
            child: CostAreaBarChart(),
          ),
         /*  Container(
            width: 200.0,
            height: 200.0,
            padding: EdgeInsets.all(10.0),
            child: MyPieChart(),
          ), */

          /* Table(
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
                          child: Text(
                            getSum(resData),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )),
                  TableDataBox(
                    boxTitle: 'Paid',
                    boxData: getSumByPaidStatus(resData, 'paid'),
                    boxColor: myGreen,
                  ),
                  TableDataBox(
                    boxTitle: 'Unpaid',
                    boxData: getSumByPaidStatus(resData, 'unpaid'),
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
                        getSumByPaidStatusAndCostArea(resData, 'paid', 'bar'),
                    boxColor: myGreen,
                  ),
                  TableDataBox(
                    boxTitle: '',
                    boxData:
                        getSumByPaidStatusAndCostArea(resData, 'unpaid', 'bar'),
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
                    boxData: getSumByPaidStatusAndCostArea(
                        resData, 'paid', 'cleaning'),
                    boxColor: myGreen,
                  ),
                  TableDataBox(
                    boxTitle: '',
                    boxData: getSumByPaidStatusAndCostArea(
                        resData, 'unpaid', 'cleaning'),
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
                    boxData: getSumByPaidStatusAndCostArea(
                        resData, 'paid', 'kitchen'),
                    boxColor: myGreen,
                  ),
                  TableDataBox(
                    boxTitle: '',
                    boxData: getSumByPaidStatusAndCostArea(
                        resData, 'unpaid', 'kitchen'),
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
                    boxData: getSumByPaidStatusAndCostArea(
                        resData, 'paid', 'operation'),
                    boxColor: myGreen,
                  ),
                  TableDataBox(
                    boxTitle: '',
                    boxData: getSumByPaidStatusAndCostArea(
                        resData, 'unpaid', 'operation'),
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
                    boxData: getSumByPaidStatusAndCostArea(
                        resData, 'paid', 'others'),
                    boxColor: myGreen,
                  ),
                  TableDataBox(
                    boxTitle: '',
                    boxData: getSumByPaidStatusAndCostArea(
                        resData, 'unpaid', 'others'),
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
                    boxData: getSumByPaidStatusAndCostArea(
                        resData, 'paid', 'toilet'),
                    boxColor: myGreen,
                  ),
                  TableDataBox(
                    boxTitle: '',
                    boxData: getSumByPaidStatusAndCostArea(
                        resData, 'unpaid', 'toilet'),
                    boxColor: myAmber,
                  ),
                ]),
              ],
            ), */
        ],
      ),
    );
  }
}

getSum(List resList) {
  num additioner = 0;
  resList.forEach((i) {
    num val = num.tryParse(i['price']) ?? 0;
    additioner += val;
  });
  // return additioner.toString();
  return additioner.toStringAsFixed(0);
}

getSumByPaidStatus(List resList, String ps) {
  num addn = 0;
  resList.forEach((i) {
    if (i['payment_status'] == ps) {
      num val = num.tryParse(i['price']) ?? 0;
      addn += val;
    }
  });
  return addn.toStringAsFixed(0);
}

getSumByPaidStatusAndCostArea(List resList, String ps, String ca) {
  num addn = 0;
  resList.forEach((i) {
    if (i['payment_status'] == ps && i['cost_area'] == ca) {
      num val = num.tryParse(i['price']) ?? 0;
      addn += val;
    }
  });
  return addn.toStringAsFixed(0);
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

class MyBarChart extends StatelessWidget {
  // final expenseData;
  const MyBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CostArea> _data = [
      new CostArea('Bar', 94000, ''),
      new CostArea('Cleaning', 24000, ''),
      new CostArea('Kitchen', 34000, ''),
      new CostArea('Operations', 26000, ''),
      new CostArea('Other(s)', 20000, ''),
      new CostArea('Toilet', 3500, '')
    ];
    List<charts.Series<CostArea, String>> _barChartData = [];
    void _makeData() {
      _barChartData.add(
        charts.Series(
            id: 'expenseByCostArea',
            domainFn: (CostArea ca, _) => ca.nameVal,
            measureFn: (CostArea ca, _) => ca.amountVal,
            colorFn: (CostArea ca, _) =>
                charts.MaterialPalette.blue.shadeDefault,
            data: _data,
            displayName: 'Cost area'),
      );
    }

    _makeData();
    return Center(
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                'Expense by cost area',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              )),
          Container(
            width: 400,
            height: 200,
            child: charts.BarChart(
              _barChartData,
              animate: true,
              animationDuration: Duration(seconds: 3),
              behaviors: [],
            ),
          )
        ],
      ),
    );

/*     return Container(
      width: 400,
      height: 200,
        child: charts.BarChart(_barChartData, animate: true, animationDuration: Duration(seconds: 3), behaviors: [],),
      
    ); */
  }
}
