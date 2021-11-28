import 'package:flutter/material.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/pages/inputs/item.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/shared/widgets.dart';
import 'package:ldgr/styles/colors.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accounts = FirestoreService().getDocumentData('accounting');
    // accounts.then((value) => print(value));
    // print(accounts);
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
              print(_data);
              print(_data.length);
              print(_data.runtimeType);
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
      floatingActionButton: FloatingAdd(),
    );
  }
}

class FloatingAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      children: [
        SpeedDialChild(
          labelWidget: Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Add item',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2.0),
            ),
            decoration: BoxDecoration(
                color: myBlue, borderRadius: BorderRadius.circular(5.0)),
          ),
          onTap: () => PageRouter().navigateToPage(AddItemPage(), context),
        ),
      ],
    );
  }
}
