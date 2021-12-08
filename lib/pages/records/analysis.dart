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
                child: Text('OVERVIEW', style: TextStyle(fontWeight: FontWeight.bold, color: myBlue),),), 
              CustomRow(rowName: 'Paid', rowData: '---'), 
              CustomRow(rowName: 'Unpaid', rowData: '---'), 
              CustomRow(rowName: 'Total', rowData: getSum(resData))      
            ],),
          );
        } else {
          return WaitingForResponse();
        }
      },
    );
  }
}

  getSum(List resList) {
    num addn = 0;
    resList.forEach((i) {
      num val = num.tryParse(i['price']) ?? 0; 
      addn += val;
    }); 
    return addn.toString();
  }


class CustomRow extends StatelessWidget {
  final String? rowName;
  final String? rowData;
  const CustomRow({Key? key, required this.rowName, required this.rowData}) : super(key: key);

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