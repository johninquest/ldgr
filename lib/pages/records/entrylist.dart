import 'package:flutter/material.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/shared/widgets.dart';

class EntryListPage extends StatelessWidget {
  const EntryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entry list'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: FirestoreService().getCollection('daybook'),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorOccured();
            }
            if (snapshot.hasData) {
              var _responseData = snapshot.data;
              return Center(child: Text('$_responseData'));
            } else {
              return WaitingForResponse();
            }
          }),
    );
  }
}
