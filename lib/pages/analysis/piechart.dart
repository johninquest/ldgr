import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ldgr/pages/analysis/chart_data_models.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Sum> _data = [
      // new Sum('Bar', 94000, ''),
      new Sum('Paid', 18006914, '0xFF00c853'),
      new Sum('Unpaid', 830943, '0xFFff8f00'),
    ];
    List<charts.Series<Sum, String>> _pieChartData = [];
    void _loadData() {
      _pieChartData.add(
        charts.Series(
            id: 'expenseTotal',
            domainFn: (Sum s, _) => s.nameVal,
            measureFn: (Sum s, _) => s.amountVal,
            colorFn: (Sum s, _) =>
                charts.ColorUtil.fromDartColor(Color(int.parse(s.colorVal))),
            data: _data,
            displayName: 'Expense'),
      );
    }

    _loadData();
    return Center(
      child: charts.PieChart(
        _pieChartData,
        animate: true,
        animationDuration: Duration(seconds: 3),
        behaviors: [],
      ),
    );
  }
}
