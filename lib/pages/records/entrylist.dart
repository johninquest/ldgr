import 'package:flutter/material.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/pages/records/entry_detail.dart';
import 'package:ldgr/services/formatter.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/shared/widgets.dart';
import 'package:ldgr/styles/style.dart';

class EntryListPage extends StatefulWidget {
  const EntryListPage({Key? key}) : super(key: key);

  @override
  State<EntryListPage> createState() => _EntryListPageState();
}

class _EntryListPageState extends State<EntryListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entry list'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: FirestoreService().getSubCollection(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorOccured();
            }
            if (snapshot.hasData) {
              List _responseData = snapshot.data as List;
              // print('Res data => _responseData');
              return SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  alignment: Alignment.center,
                  child: buildTable(_responseData),
                ),
              );
            } else {
              return WaitingForResponse();
            }
          }),
           bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget buildTable(List fsCollection) {
    if (fsCollection.length < 1) {
      return Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Center(
          child: EmptyTable(),
        ),
      );
    } else {
      final allColumns = [
        'Date',
        'Cost area',
        'Item name',
        'Price',
      ];
      return DataTable(
        columnSpacing: 20.0,
        horizontalMargin: 0.0,
        // showBottomBorder: true,
        showCheckboxColumn: false,
        columns: getColumns(allColumns),
        rows: getRows(fsCollection),
      );
    }
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(
              column,
              style: ListTitleStyle,
            ),
          ))
      .toList();

  List<DataRow> getRows(List rows) => rows
      .map(
        (e) => DataRow(
          color: MaterialStateProperty.all(Colors.transparent),
          selected: false,
          // color: MaterialStateProperty.all(myBlueLighter),
          onSelectChanged: (val) {
            if (val == true) {
              return PageRouter()
                  .navigateToPage(ItemDetailPage(rowData: e), context);
            }
          },
          cells: [
            DataCell(Text(
              Formatter().dbToUiDateTime(e['created_at'])[0] ?? '',
              // e['created_at'] ?? '',_
              style: TableItemStyle,
            )),
            DataCell(Text(
              Formatter().dbToUiValue(e['cost_area']) ?? '',
              style: TableItemStyle,
            )),
            DataCell(Text(
              e['item_name'] ?? '',
              style: TableItemStyle,
            )),
            DataCell(Text(
              e['price'] ?? '',
              style: TableItemStyle,
            )),
          ],
        ),
      )
      .toList();
}
