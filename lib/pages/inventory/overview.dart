import 'package:flutter/material.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart'; 

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
      bottomNavigationBar: BottomNavBar(),
    );
  }
}