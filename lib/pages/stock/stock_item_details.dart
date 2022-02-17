import 'package:flutter/material.dart';
import 'package:ldgr/services/formatter.dart';
import 'package:ldgr/styles/colors.dart';
import 'package:ldgr/styles/style.dart';

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
    var f = DateTimeFormatter();
    List? _events = i['events'] ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock item details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            _tableRow('Item name', i['item_name']),
            _tableRow('Purchase date', f.isoToUiDate(i['picked_date'])),
            _tableRow('Initial quantity', i['quantity']),
            _tableRow('Added', '###'),
            _tableRow(
                'Remaining quantity', computeRemaining(i['quantity'], _events)),
            SizedBox(
              height: 10.0,
            ),
            Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text('EVENT LOGS')),
            Divider(
              indent: 40.0,
              endIndent: 40.0,
              thickness: 1.0,
              color: myGrey,
            ),
            _buildTable(_events)
          ],
        ),
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
                  style: TextStyle(fontSize: 14.0, color: rowItemColor(e['event_name'])),
                  textAlign: TextAlign.left)),
              DataCell(Text(
                e['event_quantity'] ?? '',
               style: TextStyle(fontSize: 14.0, color: rowItemColor(e['event_name'])),
                textAlign: TextAlign.center,
              )),
              DataCell(Text(e['event_by'] ?? '',
                  style: TextStyle(fontSize: 14.0, color: rowItemColor(e['event_name'])),
                  textAlign: TextAlign.right)),
            ],
          ),
        )
        .toList();
    if (eventLogs != null && eventLogs.length > 0) {
      return DataTable(
          columnSpacing: 85.0,
          horizontalMargin: 0.0,
          showCheckboxColumn: false,
          columns: _tableColumns,
          rows: _tableRows(eventLogs));
    } else {
      return Center(
        child: Text('No events found!'),
      );
    }
  }
}

/* mySubtraction(String iniValue, int takenValue) {
  int valToInt = int.parse(iniValue);
  return (valToInt - takenValue).toString();
} */

computeRemaining(String _initialQty, List? _takeOutLogs) {
  if (_takeOutLogs == null) {
    return '0';
  } else if (_takeOutLogs.length < 1) {
    return '0';
  } else {
    num initialQty = num.tryParse(_initialQty) ?? 0;
    num sumRemovedQty = 0;
    for (var i in _takeOutLogs) {
      num? qTaken = num.tryParse(i['event_quantity']) ?? 0;
      sumRemovedQty += qTaken;
    }
    num remainingQty = initialQty - sumRemovedQty;
    return remainingQty.toString();
  }
}

rowItemColor(String eventType) {
  if (eventType == 'added_to_stock') {
    return myTeal;
  }
  if (eventType == 'removed_from_stock') {
    return myRed2;
  } else {
    return Colors.black;
  }
}


