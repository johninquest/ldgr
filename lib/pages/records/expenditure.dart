import 'package:flutter/material.dart';
import 'package:ldgr/styles/style.dart';
import 'package:ldgr/styles/colors.dart';
import 'package:ldgr/db/models.dart';
import 'package:ldgr/db/sqlite_helper.dart';
import 'package:ldgr/shared/widgets.dart';
import 'package:ldgr/services/formatter.dart';

class ExpenditureRecords extends StatefulWidget {
  const ExpenditureRecords({Key? key}) : super(key: key);

  @override
  _ExpenditureRecordsState createState() => _ExpenditureRecordsState();
}

class _ExpenditureRecordsState extends State<ExpenditureRecords> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenditure list', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: myRed,
      ),
      body: FutureBuilder(
        future: SQLiteDatabaseHelper().getAllExpentures(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Income> response = snapshot.data as List<Income>;
            return SingleChildScrollView(
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.95,
                alignment: Alignment.center,
                child: buildExpenditureTable(response),),);
          }
          if (snapshot.hasError) {
            return ErrorOccured();
          } else {
            return WaitingForResponse();
          }
        },
      ),
    );
  }

  Widget buildExpenditureTable(List<Income> dbList) {
    final expenditureColumns = [
      'Date',
      'Source',
      'Amount',
    ];
    return DataTable(columns: getColumns(expenditureColumns), rows: getRows(dbList));
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(
              column,
              style: ListTitleStyle,
            ),
          ))
      .toList();

  List<DataRow> getRows(List<Income> rows) => rows
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
            DataCell(Formatter().checkSplit2Words(e.source)),
            DataCell(Text(Formatter().toNoDecimal(e.amount),
              style: TableItemStyle,
            ))
          ]))
      .toList();    
}
