import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart';
import 'package:tba/data/models.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/shared/widgets.dart';
import 'package:tba/services/formatter.dart';

class ExpenditureRecords extends StatefulWidget {
  const ExpenditureRecords({Key? key}) : super(key: key);

  @override
  _ExpenditureRecordsState createState() => _ExpenditureRecordsState();
}

class _ExpenditureRecordsState extends State<ExpenditureRecords> {
/*   List<Income>? expenseList;

  @override
  initState() {
    super.initState();
    SQLiteDatabaseHelper().getAllIncomes().then((value) => expenseList = value);
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenditure list', style: TextStyle(color: Colors.redAccent),),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SQLiteDatabaseHelper().getAllExpentures(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Income> response = snapshot.data as List<Income>;
            // print(res);
            /* return Center(
              child: Text('$response'),
            ); */
            return SingleChildScrollView(
              child: Container(
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
            DataCell(Text(
              '${e.amount}',
              style: TableItemStyle,
            ))
          ]))
      .toList();    
}
