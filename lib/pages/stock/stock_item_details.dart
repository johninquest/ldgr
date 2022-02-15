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
    List? _logs = i['removals'] ?? [];
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
              height: 10.0,
            ),
            _tableRow('Item name', i['item_name']),
            _tableRow('Purchase date', f.isoToUiDate(i['picked_date'])),
            _tableRow('Initial quantity', i['quantity']),
            _tableRow('Remaining quantity', computeRemaining(i['quantity'], _logs)),
            SizedBox(
              height: 10.0,
            ),
            Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                ),
                child: Text('TAKE OUT LOGS')),
            Divider(
              indent: 40.0,
              endIndent: 40.0,
              thickness: 1.0,
              color: myGrey,
            ),
            _buildTable(_logs)
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

  Widget _buildTable(List? outgoingLogs) {
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
                  DateTimeFormatter().isoToUiDate(e['taken_at']) ?? '',
                  style: TableItemStyle,
                  textAlign: TextAlign.left)),
              DataCell(Text(
                e['quantity_taken'] ?? '',
                style: TableItemStyle,
                textAlign: TextAlign.center,
              )),
              DataCell(Text(e['taken_by'] ?? '',
                  style: TableItemStyle, textAlign: TextAlign.right)),
            ],
          ),
        )
        .toList();
    if (outgoingLogs != null && outgoingLogs.length > 0) {
      return DataTable(
          columnSpacing: 85.0,
          horizontalMargin: 0.0,
          showCheckboxColumn: false,
          columns: _tableColumns,
          rows: _tableRows(outgoingLogs));
    } else {
      return Center(
        child: Text('No logs available!'),
      );
    }
  }
}

mySubtraction(String iniValue, int takenValue) {
  int valToInt = int.parse(iniValue);
  return (valToInt - takenValue).toString();
}

computeRemaining(String _initialQty, List? _takeOutLogs) {
  if (_takeOutLogs == null) {
    return '0';
  } else if (_takeOutLogs.length < 1) {
    return '0';
  } else {
    num initialQty = num.tryParse(_initialQty) ?? 0;
    num sumRemovedQty = 0;
    for (var i in _takeOutLogs) {
      num? qTaken = num.tryParse(i['quantity_taken']) ?? 0;
      sumRemovedQty += qTaken;
    }
    num remainingQty = initialQty - sumRemovedQty;
    return remainingQty.toString();
  }
}
