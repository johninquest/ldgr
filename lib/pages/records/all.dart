import 'package:flutter/material.dart';
import 'package:tba/data/models.dart';
import 'package:tba/styles/style.dart';
import 'package:tba/pages/bottom_nav_bar.dart';
import 'package:tba/shared/widgets.dart';
import 'package:tba/shared/analysis.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/services/formatter.dart';
// import 'package:tba/pages/records/income.dart';
// import 'package:tba/pages/records/expenditure.dart';

class AllRecords extends StatelessWidget {
  const AllRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    fetchAllRecords();
    return Scaffold(
      appBar: AppBar(
        title: Text('All Records'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SumTotalBoard(expenditureSum, incomeSum),
          MyDataTable(),
        ],
      ),
      floatingActionButton: SideButtomMenu(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class MyDataTable extends StatefulWidget {
  const MyDataTable({Key? key}) : super(key: key);

  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 2.0, right: 2.0),
        child: buildTable())
        );
  }

  Widget buildTable() {
    final myColumns = [
      'Date',
      'Type',
      'Source',
      'Amount',
    ];
    return DataTable(
      columnSpacing: 20.0,
      horizontalMargin: 20.0,
      // showBottomBorder: true,
      columns: getColumns(myColumns),
      rows: getRows(allDatabaseRecords),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(
              column,
              style: ListTitleStyle,
            ),
          ))
      .toList();

  List<DataRow> getRows(List<Record> rows) => rows
      .map((e) => DataRow(cells: [
            DataCell(Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Formatter().dbToUiDateTime(e.createdAt)[0], style: TableItemStyle,), 
                Text(Formatter().dbToUiDateTime(e.createdAt)[1], style: TableItemStyle,)
              ],)),
            DataCell(Text(Formatter().dbToUiValue(e.category), style: StyleHandler().tableCategoryStyle(e.category),)),
            DataCell(Formatter().checkSplit2Words(e.source)),
            DataCell(Text('${e.amount}', style: TableItemStyle,))
          ]))
      .toList();
}

List<Record> allDatabaseRecords = [];

fetchAllRecords() {
  SQLiteDatabaseHelper().getAllRows2().then((value) {
    print(value.runtimeType);
    allDatabaseRecords = value;
  });
}
