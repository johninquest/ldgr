import 'package:flutter/material.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/pages/inventory/add_inventory.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/shared/widgets.dart';
import 'package:ldgr/styles/colors.dart';

class InventoryOverviewPage extends StatelessWidget {
  const InventoryOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _fsQuery = FirestoreService()
        .getSubCollection('records', 'stock');
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _fsQuery,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorOccured();
            }
            if (snapshot.hasData) {
              List resData = snapshot.data as List;
              // print('Raw response => ${snapshot.data}');
              // print('Response => $resData');
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('$resData')],
                ),
              );
            } else {
              return WaitingForResponse();
            }
          }),
      floatingActionButton: Container(
          decoration: BoxDecoration(
              color: myBlue,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: IconButton(
              onPressed: () =>
                  PageRouter().navigateToPage(AddInventoryPage(), context),
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
