import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ldgr/pages/analysis/chart_data_models.dart';

class CostAreaBarChart extends StatelessWidget {
  // final expenseData;
  const CostAreaBarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CostArea> _data = [
      new CostArea('Bar', 94000, '0xFF1976d2'),
      new CostArea('Cleaning', 24000, '0xFF1976d2'),
      new CostArea('Kitchen', 34000, '0xFF1976d2'),
      new CostArea('Operations', 26000, '0xFF1976d2'),
      new CostArea('Other(s)', 20000, '0xFF1976d2'),
      new CostArea('Toilet', 3500, '0xFF1976d2')
    ];
    List<charts.Series<CostArea, String>> _barChartData = [];
    void _loadData() {
      _barChartData.add(
        charts.Series(
            id: 'expenseByCostArea',
            domainFn: (CostArea ca, _) => ca.nameVal,
            measureFn: (CostArea ca, _) => ca.amountVal,
            colorFn: (CostArea ca, _) =>
                charts.ColorUtil.fromDartColor(Color(int.parse(ca.colorVal))),
            data: _data,
            displayName: 'Cost area'),
      );
    }

    _loadData();
    return Center(
        child: charts.BarChart(
      _barChartData,
      animate: true,
      animationDuration: Duration(seconds: 3),
      behaviors: [
        /* charts.DatumLegend(
          entryTextStyle: charts.TextStyleSpec(
              color: charts.MaterialPalette.black,
              fontFamily: '',
              fontSize: 15),
        ) */
      ],
    ));
  }
}
