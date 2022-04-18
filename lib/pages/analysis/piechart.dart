import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ldgr/pages/analysis/chart_data_models.dart';
import 'filters.dart';

class MyPieChart extends StatelessWidget {
  final List daybookData;
  const MyPieChart({Key? key, required this.daybookData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _filter = AnalysisFilters();
    num _paid = _filter.getSumByPaidStatus(daybookData, 'paid') ?? 0;
    num _unpaid = _filter.getSumByPaidStatus(daybookData, 'unpaid') ?? 0;
    List<Sum> _data = [
      // new Sum('Bar', 94000, ''),
      new Sum('Paid', _paid, '0xFF00c853'),
      new Sum('Unpaid', _unpaid, '0xFFff8f00'),
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
          labelAccessorFn: (Sum s, _) => '${s.nameVal}: ${s.amountVal}',
        ),
      );
    }

    _loadData();
    return Center(
      child: charts.PieChart<String>(
        _pieChartData,
        animate: true,
        animationDuration: Duration(seconds: 3),
        behaviors: [
          /* new charts.DatumLegend(
            outsideJustification: charts.OutsideJustification.endDrawArea,
            horizontalFirst: false,
            desiredMaxRows: 2,
            cellPadding: EdgeInsets.all(1.0),
            entryTextStyle: charts.TextStyleSpec(
              color: charts.MaterialPalette.black,
              fontFamily: '',
            ),
          ) */
        ],
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside)
        ]),
      ),
    );
  }
}
