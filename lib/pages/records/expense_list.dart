import 'package:flutter/material.dart';
import 'package:ldgr/filters/filter_data.dart';
import 'package:ldgr/filters/filter_logic.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/pages/records/expense_detail.dart';
import 'package:ldgr/pages/records/search.dart';
import 'package:ldgr/services/formatter.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/shared/widgets.dart';
import 'package:ldgr/styles/style.dart';

List? _fsDaybookList;

class EntryListPage extends StatelessWidget {
  const EntryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense list'),
        centerTitle: true,
        actions: [
          Container(
            child: IconButton(
                onPressed: () => PageRouter().navigateToPage(
                    SearchPage(
                      searchData: _fsDaybookList ?? [],
                    ),
                    context),
                icon: Icon(Icons.search)),
          )
        ],
      ),
      body: FutureBuilder(
          future: FirestoreService().getSubCollection(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorOccured();
            }
            if (snapshot.hasData) {
              List daybookData = snapshot.data as List;
              _fsDaybookList = daybookData;
              return EntryListTable(
                fsData: daybookData,
              );
            } else {
              return WaitingForResponse();
            }
          }),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class EntryListTable extends StatefulWidget {
  final List? fsData;
  const EntryListTable({Key? key, required this.fsData}) : super(key: key);

  @override
  State<EntryListTable> createState() => _EntryListTableState();
}

class _EntryListTableState extends State<EntryListTable> {
  int? sortColumnIndex;
  bool isAscending = false;

  String? _day;
  String? _month;
  String? _year;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Object>>? _dayList = FilterData().dayList();
    List<DropdownMenuItem<Object>>? _monthList = FilterData().monthList();
    List<DropdownMenuItem<Object>>? _yearList = FilterData().yearList();
    // List daybookRecords = widget.fsData as List;
    final daybookRecords = FilterService()
        .byDate(widget.fsData as List, _day ?? '', _month ?? '', _year ?? '');
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 5.0, top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: 'DD',
                          labelStyle: TextStyle(fontSize: 12.0)),
                      items: _dayList,
                      validator: (val) => val == null ? 'DD?' : null,
                      onChanged: (val) {
                        setState(() {
                          _day = val as String?;
                        });
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: 'MM',
                          labelStyle: TextStyle(fontSize: 12.0)),
                      items: _monthList,
                      validator: (val) => val == null ? 'MM?' : null,
                      onChanged: (val) => setState(() {
                        _month = val as String?;
                      }),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          labelText: 'YYYY',
                          labelStyle: TextStyle(fontSize: 12.0)),
                      items: _yearList,
                      validator: (val) => val == null ? 'YYYY?' : null,
                      onChanged: (val) => setState(() {
                        _year = val as String?;
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: buildTable(daybookRecords),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTable(List fsCollection) {
    if (fsCollection.length < 1) {
      return Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Center(
          child: EmptyTable(),
        ),
      );
    } else {
      final allColumns = [
        'Date',
        'Cost area',
        'Item name',
        'Price',
      ];
      return DataTable(
        sortAscending: isAscending,
        sortColumnIndex: sortColumnIndex,
        columnSpacing: 20.0,
        horizontalMargin: 0.0,
        showCheckboxColumn: false,
        columns: getColumns(allColumns),
        rows: getRows(fsCollection),
      );
    }
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(
              column,
              style: ListTitleStyle,
            ),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List rows) => rows
      .map(
        (e) => DataRow(
          color: MaterialStateProperty.all(Colors.transparent),
          selected: false,
          onSelectChanged: (val) {
            if (val == true) {
              return PageRouter()
                  .navigateToPage(ItemDetailPage(rowData: e), context);
            }
          },
          cells: [
            DataCell(Text(
                DateTimeFormatter().isoToUiDate(e['picked_date']) ?? '',
                style: TableItemStyle,
                textAlign: TextAlign.left)),
            DataCell(Text(
              Formatter().dbToUiValue(e['cost_area']) ?? '',
              style: TableItemStyle,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            )),
            DataCell(ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.20,
              ),
              child: Text(
                e['item_name'] ?? '',
                style: TableItemStyle,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
            )),
            DataCell(Text(e['price'] ?? '',
                style: StyleHandler().paymentStatus(e['payment_status']),
                textAlign: TextAlign.right)),
          ],
        ),
      )
      .toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      widget.fsData!.sort((item1, item2) =>
          compareString(ascending, item1['picked_date'], item2['picked_date']));
    } else if (columnIndex == 1) {
      widget.fsData!.sort((item1, item2) =>
          compareString(ascending, item1['cost_area'], item2['cost_area']));
    } else if (columnIndex == 2) {
      widget.fsData!.sort((item1, item2) =>
          compareString(ascending, item1['item_name'], item2['item_name']));
    } else if (columnIndex == 3) {
      widget.fsData!.sort((item1, item2) => compareString(
          ascending, item1['payment_status'], item2['payment_status']));
    }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}

/* class FloatingAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.tune,
      children: [
        SpeedDialChild(
          labelWidget: Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'under construction',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2.0),
            ),
            decoration: BoxDecoration(
                color: myBlue, borderRadius: BorderRadius.circular(5.0)),
          ),
          onTap: () => null,
        ),
      ],
    );
  }
} */