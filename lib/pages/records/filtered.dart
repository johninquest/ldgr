import 'package:flutter/material.dart';

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
      body: FilteredData(filterPeriod: periodName,),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('${widget.filterPeriod}'),
      ),
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
