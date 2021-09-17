import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart';
import 'package:tba/styles/colors.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/data/models.dart';
import 'package:tba/services/formatter.dart';
import 'package:tba/shared/widgets.dart';

class IncomeRecords extends StatefulWidget {
  const IncomeRecords({Key? key}) : super(key: key);

  @override
  _IncomeRecordsState createState() => _IncomeRecordsState();
}

class _IncomeRecordsState extends State<IncomeRecords> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income list', style: TextStyle(color: Colors.white),),
        centerTitle: true, 
        backgroundColor: myGreen,
      ),
      body: FutureBuilder(
        future: SQLiteDatabaseHelper().getAllIncomes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Income> response = snapshot.data as List<Income>;
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                child: buildIncomeTable(response),),);
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

  Widget buildIncomeTable(List<Income> dbList) {
    final incomeColumns = [
      'Date',
      'Source',
      'Amount',
    ];
    return DataTable(columns: getColumns(incomeColumns), rows: getRows(dbList));
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

