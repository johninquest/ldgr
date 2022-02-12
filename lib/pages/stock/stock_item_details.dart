import 'package:flutter/material.dart';
import 'package:ldgr/services/formatter.dart';
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
    print('Data => ${widget.stockItemData}');
    Map i = widget.stockItemData;
    var f = DateTimeFormatter();
    List? _logs = i['removals'] ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock item details'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _tableRow('Item name', i['item_name']),
            _tableRow('Purchase date', f.isoToUiDate(i['picked_date'])),
            _tableRow('Purchased quantity', i['quantity']),
            _tableRow('Remaining quantity', mySubtraction(i['quantity'], 3)),
            Container(margin: EdgeInsets.only(top: 10.0), child: Text('Outgoing logs')),
            Divider(
              indent: 40.0,
              endIndent: 40.0,
              thickness: 1.0,
              color: myGrey,
            ),
            Column(
              children: _showLogs(_logs),
            )
            // _showLogs(_logs) ?? SizedBox(),
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

  List<Widget> _showLogs(List? tLogs) {
    List<Widget> tElements = [];
    if (tLogs != null || tLogs!.isNotEmpty) {
      var dtf = DateTimeFormatter();
      for (var e in tLogs) {
        Widget _itemRow = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(dtf.isoToUiDate(e['taken_at']))),
            Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text('${e["quantity_taken"]}')),
            Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text('${e["taken_by"]}')),
          ],
        );
        tElements.add(_itemRow);
      }
    } else {
      tElements.add(Text('No items taken!'));
    }
    return tElements;
  }
}

mySubtraction(String iniValue, int takenValue) {
  int valToInt = int.parse(iniValue);
  return (valToInt - takenValue).toString();
}

/* class MyTableRow extends StatelessWidget {
  final String? rowName;
  final String? rowData;
  const MyTableRow({Key? key, this.rowName, this.rowData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              rowName!,
              style: TextStyle(color: myBlue, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 1.0, right: 5.0),
            padding: EdgeInsets.only(bottom: 1.0, right: 5.0),
            child: Text(rowData!.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
 */
