import 'package:flutter/material.dart';
import 'package:rba/db/models.dart';
import 'package:rba/db/sp_helper.dart';
import 'package:rba/db/sqlite_helper.dart';
import 'package:rba/pages/inputs/row_editor.dart';
import 'package:rba/services/currency.dart';
import 'package:rba/services/router.dart';
import 'package:rba/shared/analysis.dart';
import 'package:rba/services/formatter.dart';
import 'package:rba/shared/bottom_nav_bar.dart';
import 'package:rba/shared/widgets.dart';
import 'package:rba/styles/style.dart';

class Filtered extends StatelessWidget {
  final String periodName;
  const Filtered({Key? key, required this.periodName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitleHandler(periodName), style: AppBarTitleStyle,),
        centerTitle: true,
      ),
      body: FilteredData(
        filterPeriod: periodName,
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class FilteredData extends StatefulWidget {
  final String filterPeriod;
  const FilteredData({Key? key, required this.filterPeriod}) : super(key: key);

  @override
  _FilteredDataState createState() => _FilteredDataState();
}

class _FilteredDataState extends State<FilteredData> {
  num? expSum;
  num? incSum;
  String? currentCurrency;
  List<Record>? rowData;

  @override
  initState() {
    super.initState();
    SharedPreferencesHelper().readData('countryName').then((value) {
      if (value != null) {
        setState(() {
          String? currentCountry = value;
          currentCurrency = CurrencyHandler().fromCountry(currentCountry);
        });
      }
    });
    if (widget.filterPeriod == 'today') {
      SQLiteDatabaseHelper().getTodaySum().then((value) {
        if (value != null) {
          setState(() {
            expSum = value['sumExpToday'];
            incSum = value['sumIncToday'];
          });
        }
      });
      SQLiteDatabaseHelper().getAllRowsToday().then((value) {
        setState(() {
          rowData = value;
        });
      });
    }
    if (widget.filterPeriod == 'week') {
      SQLiteDatabaseHelper().getCurrentWeekSum().then((value) {
        if (value != null) {
          setState(() {
            expSum = value['sumExpWeek'];
            incSum = value['sumIncWeek'];
          });
        }
      });
      SQLiteDatabaseHelper().getAllRowsCurrentWeek().then((value) {
        setState(() {
          rowData = value;
        });
      });
    }
    if (widget.filterPeriod == 'month') {
      SQLiteDatabaseHelper().getCurrentMonthSum().then((value) {
        if (value != null) {
          setState(() {
            expSum = value['sumExpMonth'];
            incSum = value['sumIncMonth'];
          });
        }
      });
      SQLiteDatabaseHelper().getAllRowsCurrentMonth().then((value) {
        setState(() {
          rowData = value;
        });
      });
    }
    if (widget.filterPeriod == 'year') {
      SQLiteDatabaseHelper().getCurrentYearSum().then((value) {
        if (value != null) {
          setState(() {
            expSum = value['sumExpYear'];
            incSum = value['sumIncYear'];
          });
        }
      });
      SQLiteDatabaseHelper().getAllRowsCurrentYear().then((value) {
        setState(() {
          rowData = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: BalanceByPeriod(expSum ?? 0, incSum ?? 0,
                widget.filterPeriod, currentCurrency ?? '')),
        Expanded(
            child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            alignment: Alignment.center,
            child: buildTable(rowData ?? []),
          ),
        ))
      ],
    );
  }

  Widget buildTable(List<Record> dbRecordsList) {
    if (dbRecordsList.length < 1) {
      return Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Center(child: EmptyTable()),
      );
    }else {
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
          onSelectChanged: (val) {
            if (val == true) {
              PageRouter().navigateToPage(
                  RowEditorPage(
                    rowData: e,
                    fromPageName: widget.filterPeriod,
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

appTitleHandler(String pName) {
  if (pName == 'today') {
    return 'Today';
  }
  if (pName == 'week') {
    return 'Current week';
  }
  if (pName == 'month') {
    return 'Current month';
  }
  if (pName == 'year') {
    return 'Current year';
  } else {
    return '';
  }
}
