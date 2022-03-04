import 'package:flutter/material.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/shared/widgets.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accounts = FirestoreService().getDocument('', '');
    return Scaffold(
      appBar: AppBar(
        title: Text('Items overview'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: accounts,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorOccured();
            } else if (snapshot.hasData) {
              List _data = snapshot.data as List;
              return ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    return Text(_data[index]);
                  });
              /* return Center(
                child: Text('Snapshot has data!'),
              ); */
            } else {
              return WaitingForResponse();
            }
          }),
      // floatingActionButton: FloatingAdd(),
    );
  }
}