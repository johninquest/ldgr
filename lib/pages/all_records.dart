import 'package:flutter/material.dart';
import 'package:tba/db/sqlite_helper.dart';
import 'package:tba/shared/widgets.dart';

class AllRecordsPage extends StatelessWidget {
  // const AllRecordsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Records'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SQLiteDatabaseHelper().getAllRows(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('Response has data!');
            var responseData = snapshot.data;
            print(responseData);
            return Center(child: Text('$responseData'));
          }
          if (snapshot.hasError) {
            print('Reponse has error!');
            return ErrorOccured();
          }
          return SizedBox();
        },
      ),
    );
  }
}
