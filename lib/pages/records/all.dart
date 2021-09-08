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

List<Record>? allDatabaseRecords;
double? expenditureSumTotal;
double? incomeSumTotal;

class AllRecords extends StatelessWidget {
  const AllRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SQLiteDatabaseHelper()
        .getExpenditureSum()
        .then((value) => expenditureSumTotal = value['sum_ex']);
    SQLiteDatabaseHelper()
        .getIncomeSum()
        .then((value) => incomeSumTotal = value['sum_in']);    
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
          SumTotalBoard(expenditureSumTotal ?? 0, incomeSumTotal ?? 0),
          Expanded(child: MyDataTable(
            dbRecords: allDatabaseRecords ?? [],
          ),)
        ],
      ),
      floatingActionButton: SideButtomMenu(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class MyDataTable extends StatefulWidget {
  final List<Record> dbRecords;
  const MyDataTable({Key? key, required this.dbRecords}) : super(key: key);

  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(left: 1.0, right: 5.0),
            padding: EdgeInsets.only(right: 5.0),
            child: buildTable(widget.dbRecords)));
  }

  Widget buildTable(List<Record> dbRecordsList) {
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
      rows: getRows(dbRecordsList),
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
                Text(
                  Formatter().dbToUiDateTime(e.createdAt)[0],
                  style: TableItemStyle,
                ),
                Text(
                  Formatter().dbToUiDateTime(e.createdAt)[1],
                  style: TableItemStyle,
                )
              ],
            )),
            DataCell(Text(
              Formatter().dbToUiValue(e.category),
              style: StyleHandler().tableCategoryStyle(e.category),
            )),
            DataCell(Formatter().checkSplit2Words(e.source)),
            DataCell(Text(
              '${e.amount}',
              style: TableItemStyle,
            ))
          ]))
      .toList();
}

fetchAllRecords() {
  SQLiteDatabaseHelper().getAllRows2().then((value) {
    print(value.runtimeType);
    allDatabaseRecords = value;
  });
}
