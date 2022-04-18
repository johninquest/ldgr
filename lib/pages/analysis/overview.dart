import 'package:flutter/material.dart';
import 'package:ldgr/filters/filter_data.dart';
import 'package:ldgr/filters/filter_logic.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/pages/analysis/analysis_table.dart';
import 'package:ldgr/pages/analysis/barchart.dart';
import 'package:ldgr/pages/analysis/piechart.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/shared/widgets.dart';

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
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.all(1.0),
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.width * 0.50,
            child: CostAreaBarChart(
              daybookData: resData ?? [],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.all(1.0),
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.width * 0.45,
            child: MyPieChart(
              daybookData: resData ?? [],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 0.50, right: 0.50),
            width: MediaQuery.of(context).size.width * 0.90,
            // height: MediaQuery.of(context).size.width * 0.45,
            child: AnalysisTable(daybookData: resData),
          ),
          // AnalysisTable(daybookData: resData),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}