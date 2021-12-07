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
                child: Text('expenses total'.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: myBlue),),), 
              Container(
                margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                child: Text(getSum(resData), style: TextStyle(fontWeight: FontWeight.bold),)),
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
