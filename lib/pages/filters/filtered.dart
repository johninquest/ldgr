import 'package:flutter/material.dart';
import 'package:tba/data/sp_helper.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/services/currency.dart';
import 'package:tba/services/preprocessor.dart';
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
  String? currentCurrency;

  @override
  initState() {
    super.initState();
    SharedPreferencesHelper().readData('personData').then((value) {
      if (value != null) {
        print(value);
        setState(() {
          String? currentCountry = DataParser().strToMap(value)['country'];
          currentCurrency = CurrencyHandler().fromCountry(currentCountry);
          print(currentCountry);
          print(currentCurrency);
        });
      }
    });
    if (widget.filterPeriod == 'today') {
      SQLiteDatabaseHelper().getSumToday().then((value) {
        if (value != null) {
          setState(() {
            expSum = value['sumExpToday'];
            incSum = value['sumIncToday'];
          });
        }
      });
      SQLiteDatabaseHelper().getAllRowsToday().then((value) => print(value.length));
    }
    if (widget.filterPeriod == 'week') {
      SQLiteDatabaseHelper().getSumByWeek().then((value) {
        if (value != null) {
          setState(() {
            expSum = value['sumExpWeek'];
            incSum = value['sumIncWeek'];
          });
        }
      });
      SQLiteDatabaseHelper().getAllRowsCurrentWeek().then((value) => print(value.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: BalanceByPeriod(expSum ?? 0, incSum ?? 0,
                widget.filterPeriod, currentCurrency ?? '')),
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
