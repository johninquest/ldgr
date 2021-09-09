import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/data/models.dart';
import 'package:tba/services/formatter.dart';

class IncomeRecords extends StatelessWidget {
  // const IncomeRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SQLiteDatabaseHelper().getAllIncomes().then((value) => incomeList = value);
    return Scaffold(
        appBar: AppBar(
          title: Text('Income list'),
          centerTitle: true,
        ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [Expanded(child: IncomeTable())],
        ));
  }
}

List<Income>? incomeList;
Map? incomeSumTotal;

class IncomeTable extends StatefulWidget {
  // final List<Income> myList;
  // IncomeTable(this.myList);
  //const IncomeTable({Key? key}) : super(key: key);

  @override
  _IncomeTableState createState() => _IncomeTableState();
}

class _IncomeTableState extends State<IncomeTable> {
  // List<Income>? myList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            // margin: EdgeInsets.only(left: 1.0, right: 4.0),
            // padding: EdgeInsets.only(right: 4.0),
            alignment: Alignment.center,
            child: buildIncomeTable(incomeList ?? [])));
  }

  buildIncomeTable(List<Income> incList) {
    final incomeColumns = [
      'Date',
      'Source',
      'Amount',
    ];

    return DataTable(
      // columnSpacing: 30.0,
      // horizontalMargin: 10.0,
      // showBottomBorder: true,
      columns: getColumns(incomeColumns),
      rows: getRows(incList),
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
