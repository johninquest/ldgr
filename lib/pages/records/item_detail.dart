import 'package:flutter/material.dart';
import 'package:ldgr/services/date_time_helper.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/shared/dialogs.dart';
import 'package:ldgr/styles/colors.dart';

class ItemDetailPage extends StatelessWidget {
  final rowData;
  const ItemDetailPage({Key? key, required this.rowData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('Row data => $rowData');
    return Scaffold(
      appBar: AppBar(
        title: Text('Item details'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        MyTableRow(
          rowName: 'Date',
          rowData: DateTimeHelper().toUiDateTime(rowData['created_at']),
        ),
        MyTableRow(
          rowName: 'Account',
          rowData: rowData['account'] ?? '',
        ),
        MyTableRow(
          rowName: 'Cost area',
          rowData: rowData['cost_area'] ?? '',
        ),
        MyTableRow(
          rowName: 'Item categoy',
          rowData: rowData['item_category'] ?? '',
        ),
        MyTableRow(
          rowName: 'Item name',
          rowData: rowData['item_name'] ?? '',
        ),
        MyTableRow(
          rowName: 'Price',
          rowData: rowData['price'] ?? '',
        ),
        MyTableRow(
            rowName: 'Quantity',
            rowData: '${rowData['quantity']} ${rowData['unit']}'),
        MyTableRow(
          rowName: 'Payment method',
          rowData: rowData['payment_method'] ?? '',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: ElevatedButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (_) => InfoDialog('Coming soon')),
                child: Text('DELETE'),
                style: ElevatedButton.styleFrom(primary: myRed),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () => showDialog(
                    context: context,
                    builder: (_) => InfoDialog('Coming soon')),
                child: Text('UPDATE'),
                style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              ),
            )
          ],
        ),
      ])),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class MyTableRow extends StatelessWidget {
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
