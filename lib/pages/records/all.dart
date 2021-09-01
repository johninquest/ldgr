import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart';
import 'package:tba/pages/bottom_nav_bar.dart';
import 'package:tba/shared/widgets.dart';
import 'package:tba/db/sqlite_helper.dart';

class AllRecords extends StatelessWidget {
  const AllRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // fetchAllRecords();
    return Scaffold(
      appBar: AppBar(
        title: Text('All Records'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: MyDataTable(),
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
    return buildTable();
  }

  Widget buildTable() {
    final myColumns = [
      'Date',
      'Category',
      'Source',
      'Amount',
    ];
    fetchAllRecords();
    return DataTable(
        columns: getColumns(myColumns),
        rows: []
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

  dynamic allDatabaseRecords;

  fetchAllRecords() {
    SQLiteDatabaseHelper().getAllRows().then(
        (value) => {
          print(value[0]), 
          allDatabaseRecords = value});
  }
}

/* dynamic allDatabaseRecords;

fetchAllRecords() {
  SQLiteDatabaseHelper().getAllRows().then((value) => {
        // print(value),
        allDatabaseRecords = value
      });
} */
