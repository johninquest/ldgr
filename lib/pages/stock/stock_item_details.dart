import 'package:flutter/material.dart';
import 'package:ldgr/pages/stock/calculations.dart';
import 'package:ldgr/utils/formatter.dart';
import 'package:ldgr/styles/colors.dart';

class StockItemDetails extends StatefulWidget {
  final Map stockItemData;
  const StockItemDetails({Key? key, required this.stockItemData})
      : super(key: key);

  @override
  State<StockItemDetails> createState() => _StockItemDetailsState();
}

class _StockItemDetailsState extends State<StockItemDetails> {
  @override
  Widget build(BuildContext context) {
    Map i = widget.stockItemData;
    List? _events = i['events'] ?? [];
    var _dtFormatter = DateTimeFormatter();
    var _calculator = StockCalculations();
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock item details'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          _tableRow('Item name', i['item_name']),
          _tableRow(
              'Purchase date', _dtFormatter.isoToUiDate(i['picked_date'])),
          _tableRow('By', i['entered_by']),
          _tableRow('Initial quantity', i['quantity']),
          _tableRowWithColor(
              'Added', '${_calculator.sumOfAddedItems(_events)}', myTeal),
          _tableRowWithColor(
              'Removed', '${_calculator.sumOfRemovedItems(_events)}', myRed),
          _tableRow('Remaining',
              '${_calculator.computeRemainingItems(i['quantity'], _calculator.sumOfAddedItems(_events), _calculator.sumOfRemovedItems(_events))}'),
          SizedBox(
            height: 10.0,
          ),
          Container(
              margin: EdgeInsets.only(
                top: 10.0,
              ),
              child: Text('PROTOCOL')),
          Divider(
            indent: 50.0,
            endIndent: 50.0,
            thickness: 1.0,
            color: myGrey,
          ),
          Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, child: _buildTable(_events)))
        ],
      ),
    );
  }

  Widget _tableRow(String? _title, String? _data) {
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
              _title ?? '',
              style: TextStyle(color: myBlue, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 1.0, right: 5.0),
            padding: EdgeInsets.only(bottom: 1.0, right: 5.0),
            child: Text(_data ?? '',
                style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _tableRowWithColor(String? rTitle, String? rData, Color rColorName) {
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
              rTitle ?? '',
              style: TextStyle(color: rColorName, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 1.0, right: 5.0),
            padding: EdgeInsets.only(bottom: 1.0, right: 5.0),
            child: Text(rData ?? '',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: rColorName)),
          )
        ],
      ),
    );
  }

  Widget _buildTable(List? eventLogs) {
    List<DataColumn> _tableColumns = [
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('Quantity')),
      DataColumn(label: Text('By')),
    ];
    List<DataRow> _tableRows(List rows) => rows
        .map(
          (e) => DataRow(
            color: MaterialStateProperty.all(Colors.transparent),
            selected: false,
            cells: [
              DataCell(Text(
                  DateTimeFormatter().isoToUiDate(e['event_timestamp']) ?? '',
                  style: TextStyle(
                      fontSize: 14.0, color: rowItemColor(e['event_name'])),
                  textAlign: TextAlign.left)),
              DataCell(Text(
                e['event_quantity'] ?? '',
                style: TextStyle(
                    fontSize: 14.0, color: rowItemColor(e['event_name'])),
                textAlign: TextAlign.center,
              )),
              DataCell(Text(e['event_by'] ?? '',
                  style: TextStyle(
                      fontSize: 14.0, color: rowItemColor(e['event_name'])),
                  textAlign: TextAlign.right)),
            ],
          ),
        )
        .toList();
    if (eventLogs != null && eventLogs.length > 0) {
      eventLogs
          .sort((a, b) => b['event_timestamp'].compareTo(a['event_timestamp']));
      return DataTable(
          columnSpacing: 85.0,
          horizontalMargin: 0.0,
          showCheckboxColumn: false,
          columns: _tableColumns,
          rows: _tableRows(eventLogs));
    } else {
      return Center(
        child: Text('No protocol information found!'),
      );
    }
  }
}

rowItemColor(String eventName) {
  if (eventName == 'added_to_stock') {
    return myTeal;
  }
  if (eventName == 'removed_from_stock') {
    return myRed;
  } else {
    return Colors.black;
  }
}
