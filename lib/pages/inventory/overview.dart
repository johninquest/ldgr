import 'package:flutter/material.dart';
import 'package:ldgr/pages/inventory/add_inventory.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/styles/colors.dart'; 

class InventoryOverviewPage extends StatelessWidget {
  const InventoryOverviewPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overview'),
        centerTitle: true,
      ),
      body: Center(child: Text('Inventory overview'),),
      floatingActionButton: Container(
        decoration: BoxDecoration(color: myBlue, borderRadius: BorderRadius.all(Radius.circular(25))),
        child: IconButton(onPressed: () => PageRouter()
                    .navigateToPage(AddInventoryPage(), context), icon: Icon(Icons.add, color: Colors.white,))),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
