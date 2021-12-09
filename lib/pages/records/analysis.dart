import 'package:flutter/material.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/shared/widgets.dart';
import 'package:ldgr/styles/colors.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis'),
        centerTitle: true,
      ),
      body: AnalysisDashboard(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class AnalysisDashboard extends StatefulWidget {
  const AnalysisDashboard({Key? key}) : super(key: key);

  @override
  _AnalysisDashboardState createState() => _AnalysisDashboardState();
}

class _AnalysisDashboardState extends State<AnalysisDashboard> {
  @override
  Widget build(BuildContext context) {
    var _fsQuery = FirestoreService().getSubCollection();
    return FutureBuilder(
      future: _fsQuery,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorOccured();
        }
        if (snapshot.hasData) {
          List resData = snapshot.data as List;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                  child: Text(
                    'OVERVIEW',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: myBlue),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text('###'),
                    ),
                    Container(
                        // width: MediaQuery.of(context).size.width * 0.25,
                        margin: EdgeInsets.only(right: 20.0, top: 10.0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10.0),
                              child: Text(
                                'Paid',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: myGreen),
                              ),
                            ),
                            Container(
                              child: Text(getSumByPaidStatus(resData, 'paid')),
                            )
                          ],
                        )),
                    Container(
                        // width: MediaQuery.of(context).size.width * 0.25,
                        margin: EdgeInsets.only(left: 20.0, top: 10.0),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10.0),
                              child: Text(
                                'Unpaid',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: myAmber),
                              ),
                            ),
                            Container(
                              child:
                                  Text(getSumByPaidStatus(resData, 'unpaid')),
                            ),
                          ],
                        )),
                  ],
                ),
                AnalysisRow(
                  w1: Container(
                      child: Text(
                    'Bar',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: myBlue),
                  )),
                  w2: DataBox(
                      boxData: getSumByPaidStatusAndCostArea(
                          resData, 'paid', 'bar')),
                  w3: DataBox(
                      boxData: getSumByPaidStatusAndCostArea(
                          resData, 'unpaid', 'bar')),
                ),
                AnalysisRow(
                  w1: Container(
                      child: Text(
                    'Cleaning',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: myBlue),
                  )),
                  w2: DataBox(
                      boxData: getSumByPaidStatusAndCostArea(
                          resData, 'paid', 'cleaning')),
                  w3: DataBox(
                      boxData: getSumByPaidStatusAndCostArea(
                          resData, 'unpaid', 'cleaning')),
                ),
                AnalysisRow(
                  w1: Container(
                      child: Text(
                    'Kitchen',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: myBlue),
                  )),
                  w2: DataBox(
                      boxData: getSumByPaidStatusAndCostArea(
                          resData, 'paid', 'kitchen')),
                  w3: DataBox(
                      boxData: getSumByPaidStatusAndCostArea(
                          resData, 'unpaid', 'kitchen')),
                ),
                AnalysisRow(
                  w1: Container(
                      child: Text(
                    'Operation',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: myBlue),
                  )),
                  w2: DataBox(
                      boxData: getSumByPaidStatusAndCostArea(
                          resData, 'paid', 'operation')),
                  w3: DataBox(
                      boxData: getSumByPaidStatusAndCostArea(
                          resData, 'unpaid', 'operation')),
                ),
                AnalysisRow(
                  w1: Container(
                      child: Text(
                    'Other(s)',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: myBlue),
                  )),
                  w2: DataBox(
                      boxData: getSumByPaidStatusAndCostArea(
                          resData, 'paid', 'others')),
                  w3: DataBox(
                      boxData: getSumByPaidStatusAndCostArea(
                          resData, 'unpaid', 'others')),
                ),
                AnalysisRow(
                  w1: Container(
                      child: Text(
                    'Toilet',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, color: myBlue),
                  )),
                  w2: DataBox(
                      boxData: getSumByPaidStatusAndCostArea(
                          resData, 'paid', 'toilet')),
                  w3: DataBox(
                      boxData: getSumByPaidStatusAndCostArea(
                          resData, 'unpaid', 'toilet')),
                ), 
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Container(
                    child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold, color: myBlue),),), 
                    Container(
                      child: Text(getSum(resData), style: TextStyle(fontWeight: FontWeight.bold),),)
                    ],)
              ],
            ),
          );
        } else {
          return WaitingForResponse();
        }
      },
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

class AnalysisRow extends StatelessWidget {
  // const AnalysisRow({ Key? key }) : super(key: key);
  final Widget? w1;
  final Widget? w2;
  final Widget? w3;
  const AnalysisRow(
      {Key? key, required this.w1, required this.w2, required this.w3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
    children: [
      w1!,
      Container(
          // width: MediaQuery.of(context).size.width * 0.25,
          margin: EdgeInsets.only(right: 20.0, top: 10.0),
          child: Column(
            children: [
              /* Container(
                              margin: EdgeInsets.all(10.0),
                              child: Text(
                                'Paid',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: myGreen),
                              ),
                            ), */
              Container(
                child: w2,
              )
            ],
          )),
      Container(
          // width: MediaQuery.of(context).size.width * 0.25,
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: Column(
            children: [
              /* Container(
                              margin: EdgeInsets.all(10.0),
                              child: Text(
                                'Unpaid',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: myAmber),
                              ),
                            ), */
              Container(
                child: w3,
              ),
            ],
          )),
    ]);
  }
}

class DataBox extends StatelessWidget {
  // final String? boxName;
  final String? boxData;
  const DataBox({Key? key, required this.boxData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.25,
      margin: EdgeInsets.all(10.0),
      child: Container(
        child: Text(boxData!),
      ),
      /* child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                child: Text(
                  boxName!,
                  style: TextStyle(fontWeight: FontWeight.bold, color: myGreen),
                ),
              ),
              Container(
                child: Text(boxData!),
              )
            ],
          ) */
    );
  }
}

class CustomRow extends StatelessWidget {
  final String? rowName;
  final String? rowData;
  const CustomRow({Key? key, required this.rowName, required this.rowData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: myBlue, width: 1.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 1.0, left: 5.0),
            padding: EdgeInsets.only(bottom: 1.0, left: 5.0),
            child: Text(
              rowName!,
              style: TextStyle(color: myBlue, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 1.0, right: 5.0),
            padding: EdgeInsets.only(bottom: 1.0, right: 5.0),
            child: Text(rowData!.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
