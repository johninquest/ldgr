import 'package:flutter/material.dart';
import 'package:tba/data/models.dart';
import 'package:tba/styles/style.dart';
import 'package:tba/styles/colors.dart';
import 'package:tba/pages/bottom_nav_bar.dart';
import 'package:tba/shared/widgets.dart';
import 'package:tba/shared/analysis.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/services/formatter.dart';


class AllRecords extends StatefulWidget {
  const AllRecords({Key? key}) : super(key: key);

  @override
  _AllRecordsState createState() => _AllRecordsState();
}

class _AllRecordsState extends State<AllRecords> {
  double? expenditureSumTotal;
  double? incomeSumTotal;

  @override
  initState() {
    super.initState();
    SQLiteDatabaseHelper()
        .getExpenditureSum()
        .then((value) => expenditureSumTotal = value['sum_ex']);
    SQLiteDatabaseHelper()
        .getIncomeSum()
        .then((value) => incomeSumTotal = value['sum_in']);    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All'),
        centerTitle: true, 
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: SQLiteDatabaseHelper().getAllRows2(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Record> response = snapshot.data as List<Record>;
            return Column(
              children: [
                SumTotalBoard(expenditureSumTotal ?? 0, incomeSumTotal ?? 0),
                Expanded(
              child: SingleChildScrollView(child: Container(
                alignment: Alignment.center,
                child: buildTable(response),),))
            ],); 
          }
          if (snapshot.hasError) {
            return ErrorOccured();
          } else {
            return WaitingForResponse();
          }
        },
      ),
      floatingActionButton: SideButtomMenu(),
      bottomNavigationBar: BottomNavBar(),
    );
  }

 Widget buildTable(List<Record> dbRecordsList) {
    final allColumns = [
      'Date',
      'Type',
      'Source',
      'Amount',
    ];
    return DataTable(
      columnSpacing: 30.0,
      horizontalMargin: 10.0,
      // showBottomBorder: true,
      columns: getColumns(allColumns),
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

