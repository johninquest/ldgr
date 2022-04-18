import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ldgr/pages/analysis/chart_data_models.dart';
import 'filters.dart';

class CostAreaBarChart extends StatelessWidget {
  final List daybookData;
  const CostAreaBarChart({Key? key, required this.daybookData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _filter = AnalysisFilters();
     num _bar = _filter.getSumByCostArea(daybookData, 'bar') ?? 0; 
     num _cleaning = _filter.getSumByCostArea(daybookData, 'cleaning') ?? 0; 
     num _kitchen = _filter.getSumByCostArea(daybookData, 'kitchen') ?? 0; 
     num _operation = _filter.getSumByCostArea(daybookData, 'operation') ?? 0; 
     num _others = _filter.getSumByCostArea(daybookData, 'others') ?? 0;
     num _toilet = _filter.getSumByCostArea(daybookData, 'toilet') ?? 0;
    List<CostArea> _data = [
      new CostArea('Bar', _bar, '0xFF1976d2'),
      new CostArea('Cleaning', _cleaning, '0xFF1976d2'),
      new CostArea('Kitchen', _kitchen, '0xFF1976d2'),
      new CostArea('Operation', _operation, '0xFF1976d2'),
      new CostArea('Other(s)', _others, '0xFF1976d2'),
      new CostArea('Toilet', _toilet, '0xFF1976d2')
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
            labelAccessorFn: (CostArea ca, _) => '${ca.amountVal}'),
            
      );
    }

    _loadData();
    return Center(
        child: charts.BarChart(
      _barChartData,
      animate: true,
      vertical: false,
      animationDuration: Duration(seconds: 3), 
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      /* domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()), */
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
