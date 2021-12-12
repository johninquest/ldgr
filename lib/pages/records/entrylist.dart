import 'package:flutter/material.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/pages/records/entry_detail.dart';
import 'package:ldgr/services/formatter.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/shared/widgets.dart';
import 'package:ldgr/styles/style.dart';

class EntryListPage extends StatefulWidget {
  const EntryListPage({Key? key}) : super(key: key);

  @override
  State<EntryListPage> createState() => _EntryListPageState();
}

class _EntryListPageState extends State<EntryListPage> {
  List? _collectionData;
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();
    FirestoreService().getSubCollection().then((val) {
      if (val != null) {
        setState(() {
          _collectionData = val;
        });
      }
    }).catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entry list'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: buildTable(_collectionData ?? []),
        ),
      ),
      /* FutureBuilder(
          future: FirestoreService().getSubCollection(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorOccured();
            }
            if (snapshot.hasData) {
              _collectionData = snapshot.data as List;
              /* setState(() {
                _collectionData = snapshot.data as List;
              }); */
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: buildTable(_collectionData!),
                ),
              );
            } else {
              return WaitingForResponse();
            }
          }), */
      bottomNavigationBar: BottomNavBar(),
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
          // color: MaterialStateProperty.all(myBlueLighter),
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
      _collectionData!.sort((item1, item2) =>
          compareString(ascending, item1['picked_date'], item2['picked_date']));
    } else if (columnIndex == 1) {
      _collectionData!.sort((item1, item2) =>
          compareString(ascending, item1['cost_area'], item2['cost_area']));
    }  else if (columnIndex == 2) {
      _collectionData!.sort((item1, item2) =>
          compareString(ascending, item1['item_name'], item2['item_name']));
    }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
