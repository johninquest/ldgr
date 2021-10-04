import 'package:flutter/material.dart';
import 'package:tba/data/models.dart';
import 'package:tba/services/date_time_helper.dart';
import 'package:tba/styles/colors.dart';
import 'package:tba/shared/lists.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/services/router.dart';
import 'package:tba/services/preprocessor.dart';
import 'package:tba/pages/records/all.dart';

class RowEditor extends StatelessWidget {
  final Record rowData;
  const RowEditor({Key? key, required this.rowData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: setPageTitle(rowData.category),
        centerTitle: true,
        automaticallyImplyLeading: true, 
        backgroundColor: setPageTitleBackgroundColor(rowData.category),
      ),
      body: Container(
        child: Center(
        child: Text(
            '${rowData.id}, ${rowData.createdAt}, ${rowData.category}, ${rowData.source}, ${rowData.amount}'),
      ),
    ));
  }
}

setPageTitle(String? recordCategory) {
  if (recordCategory != null && recordCategory != '') {
    if (recordCategory == 'expenditure') {
      return Text('Edit expenditure');
    }
    if (recordCategory == 'income') {
      return Text('Edit income');
    }
  } else
    return Text('Nada');
}

setPageTitleBackgroundColor(String? recordCategory) {
  if (recordCategory != null && recordCategory != '') {
    if (recordCategory == 'expenditure') {
      return myRed;
    }
    if (recordCategory == 'income') {
      return myGreen;
    }
  } else
    return myBlue;
}