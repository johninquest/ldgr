import 'package:flutter/material.dart';
import 'package:ldgr/db/models.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/pages/inputs/row_editor.dart';
// import 'package:rba/services/preprocessor.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/shared/floating_side_menu.dart';
import 'package:ldgr/styles/style.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/shared/widgets.dart';
import 'package:ldgr/shared/analysis.dart';
import 'package:ldgr/db/sqlite_helper.dart';
import 'package:ldgr/services/formatter.dart';
import 'package:ldgr/db/sp_helper.dart';

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
        setState(() {
          expenditureSumTotal = value['sumExp'];
          incomeSumTotal = value['sumInc'];
        });
      }
    });
    SharedPreferencesHelper().readData('countryName').then((value) {
      if (value != null) {
        setState(() {
          currentCountry = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService().getCollection('daybook').then((val) => print(val));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All records',
          style: AppBarTitleStyle,
        ),
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
    if (dbRecordsList.length < 1) {
      return Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Center(
          child: EmptyTable(),
        ),
      );
    } else {
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
              PageRouter().navigateToPage(
                  RowEditorPage(
                    rowData: e,
                    fromPageName: 'all',
                  ),
                  context);
            }
          },
          cells: [
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
