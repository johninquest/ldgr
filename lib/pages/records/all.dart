import 'package:flutter/material.dart';
import 'package:tba/pages/bottom_nav_bar.dart';
import 'package:tba/shared/widgets.dart';
import 'package:tba/db/sqlite_helper.dart';

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
      body: Container(
        child: Center(
          child: Text('$allDbRecords'),
        ),
      ),
      floatingActionButton: SideButtomMenu(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

dynamic allDbRecords;

fetchAllRecords() {
  SQLiteDatabaseHelper().getAllRows().then((value) => {
    // print(value), 
    allDbRecords = value
    });
}

class MyDataTable extends StatefulWidget {
  const MyDataTable({Key? key}) : super(key: key);

  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
