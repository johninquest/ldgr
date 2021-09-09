import 'package:flutter/material.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/shared/widgets.dart';

class ExpenditureRecords extends StatelessWidget {
  const ExpenditureRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenditure list'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SQLiteDatabaseHelper().getAllExpentures(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            var res = snapshot.data;
            print(res);
            return Center(child: Text('$res'),);
          }if(snapshot.hasError) {
            return ErrorOccured();
          }else {
            return WaitingForResponse();
          }
        },
      ),
    );
  }
}
