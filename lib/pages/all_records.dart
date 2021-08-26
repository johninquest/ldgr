import 'dart:convert';

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
            List responseRaw = snapshot.data as List;
            print(responseRaw.runtimeType);
            // return Center(child: Text('$responseData'));
            return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTitle(),
                /* ListView.builder(
                    itemCount: responseRaw.length,
                    itemBuilder: (context, index) {
                  String rDate = responseRaw['created_at'];
                  String rCategory = responseRaw['category'];
                  String rSource = responseRaw['created_at'];
                  String rAmount = responseRaw['created_at'];
                }) */
              ],
            );
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
