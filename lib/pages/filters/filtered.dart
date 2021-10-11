import 'package:flutter/material.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/shared/analysis.dart';

class Filtered extends StatelessWidget {
  final String periodName;
  const Filtered({Key? key, required this.periodName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitleHandler(periodName)),
        centerTitle: true,
      ),
      body: FilteredData(
        filterPeriod: periodName,
      ),
    );
  }
}

class FilteredData extends StatefulWidget {
  final String filterPeriod;
  const FilteredData({Key? key, required this.filterPeriod}) : super(key: key);

  @override
  _FilteredDataState createState() => _FilteredDataState();
}

class _FilteredDataState extends State<FilteredData> {
  num? expSum;
  num? incSum;

  @override
  initState() {
    super.initState();
    if (widget.filterPeriod == 'today') {
      SQLiteDatabaseHelper().getSumToday().then((value) {
        if (value != null) {
          print(value);
          expSum = value['sumExpToday'];
          incSum = value['sumIncToday'];
        }
      });
    }
    if (widget.filterPeriod == 'week') {
      SQLiteDatabaseHelper().getSumByWeek().then((value) {
        if (value != null) {
          print(value);
          expSum = value['sumExpWeek'];
          incSum = value['sumIncWeek'];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child:
                BalanceByPeriod(expSum ?? 0, incSum ?? 0, widget.filterPeriod)),
        Container(
          margin: EdgeInsets.all(10.0),
          child: Center(
            child: Text('Hello world!'),
          ),
        )
      ],
    );
  }
}

appTitleHandler(String pName) {
  if (pName == 'today') {
    return 'Today';
  }
  if (pName == 'week') {
    return 'Current week';
  }
  if (pName == 'month') {
    return 'Current month';
  }
  if (pName == 'year') {
    return 'Current year';
  } else {
    return '';
  }
}
