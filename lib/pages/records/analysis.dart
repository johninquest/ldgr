import 'package:flutter/material.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/shared/widgets.dart';
import 'package:ldgr/styles/colors.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _fsQuery = FirestoreService().getSubCollection();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Analysis'),
        centerTitle: true,
      ),
      // body: AnalysisDashboard(),
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
  @override
  Widget build(BuildContext context) {
    final resData = widget.fsData;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.0, top: 30.0),
              child: Text(
                '',
                style: TextStyle(color: myBlue, fontWeight: FontWeight.bold),
              ),
            ),
            Table(
              // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              // border: TableBorder.all(),
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
                            getSum(resData),
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
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
                    boxData:
                        getSumByPaidStatusAndCostArea(resData, 'paid', 'kitchen'),
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
                    boxData:
                        getSumByPaidStatusAndCostArea(resData, 'paid', 'others'),
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
                    boxData:
                        getSumByPaidStatusAndCostArea(resData, 'paid', 'toilet'),
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
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        decoration: InputDecoration(labelText: 'Month'),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.20, 
                     
                      margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: InputDecoration(labelText: 'Year'),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.18, 
                    margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: ElevatedButton(
                      child: Text('Filter'),
                      onPressed: () => print('Tapped button!'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
  return additioner.toString();
}

getSumByPaidStatus(List resList, String ps) {
  num addn = 0;
  resList.forEach((i) {
    if (i['payment_status'] == ps) {
      num val = num.tryParse(i['price']) ?? 0;
      addn += val;
    }
  });
  return addn.toString();
}

getSumByPaidStatusAndCostArea(List resList, String ps, String ca) {
  num addn = 0;
  resList.forEach((i) {
    if (i['payment_status'] == ps && i['cost_area'] == ca) {
      num val = num.tryParse(i['price']) ?? 0;
      addn += val;
    }
  });
  return addn.toString();
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

