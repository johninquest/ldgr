import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tba/data/models.dart';
import 'package:tba/pages/filters/overview.dart';
import 'package:tba/pages/inputs/row_editor.dart';
import 'package:tba/services/preprocessor.dart';
import 'package:tba/services/router.dart';
import 'package:tba/shared/filter_menu.dart';
import 'package:tba/styles/colors.dart';
import 'package:tba/shared/floating_side_menu.dart';
import 'package:tba/styles/style.dart';
// import 'package:tba/styles/colors.dart';
import 'package:tba/shared/bottom_nav_bar.dart';
import 'package:tba/shared/widgets.dart';
import 'package:tba/shared/analysis.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/services/formatter.dart';
import 'package:tba/data/sp_helper.dart';

class AllRecords extends StatefulWidget {
  const AllRecords({Key? key}) : super(key: key);

  @override
  _AllRecordsState createState() => _AllRecordsState();
}

class _AllRecordsState extends State<AllRecords> {
  num? expenditureSumTotal;
  num? incomeSumTotal;
  String? currentCountry;

  @override
  initState() {
    super.initState();
    SQLiteDatabaseHelper().getSumAll().then((value) {
      if (value != null) {
       /*  print('Sum exp => ${value["sumExp"]}');
        print('Sum inc => ${value["sumInc"]}'); */
        expenditureSumTotal = value['sumExp'];
        incomeSumTotal = value['sumInc'];
      }
    });
    SharedPreferencesHelper().readData('personData').then((value) {
      if (value != null) {
        currentCountry = DataParser().strToMap(value)['country'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All records'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SQLiteDatabaseHelper().getAllRows(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Record> response = snapshot.data as List<Record>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SumTotalBoard(expenditureSumTotal ?? 0, incomeSumTotal ?? 0,
                    currentCountry ?? ''),
                Expanded(
                    child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    alignment: Alignment.center,
                    child: buildTable(response),
                  ),
                ))
              ],
            );
          }
          if (snapshot.hasError) {
            return ErrorOccured();
          } else {
            return WaitingForResponse();
          }
        },
      ),
      floatingActionButton: FloatingSideMenu(),
      // endDrawer: FilterMenu(),
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
      columnSpacing: 15.0,
      horizontalMargin: 0.0,
      // showBottomBorder: true,
      showCheckboxColumn: false,
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
      .map(
        (e) => DataRow(
          selected: false,
          // color: MaterialStateProperty.all(myBlueLighter),
          onSelectChanged: (val) {
            if (val == true) {
              PageRouter().navigateToPage(RowEditorPage(rowData: e), context);
            }
          },
          cells: [
            /*  DataCell(Column(
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
            )), */
            DataCell(Text(
              Formatter().dbToUiDateTime(e.createdAt)[0],
              style: TableItemStyle,
            )),
            DataCell(Text(
              Formatter().dbToUiValue(e.category),
              style: StyleHandler().tableCategoryStyle(e.category),
            )),
            DataCell(Formatter().checkSplit2Words(e.source)),
            DataCell(
              Text(
                Formatter().toNoDecimal(e.amount),
                style: TableItemStyle,
              ),
            )
          ],
        ),
      )
      .toList();
}
