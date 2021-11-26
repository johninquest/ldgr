import 'package:flutter/material.dart';
import 'package:ldgr/pages/inputs/item.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/styles/colors.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items overview'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            /*  Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0 ),
            child: ElevatedButton(
              onPressed: () => PageRouter().navigateToPage(AddItemPage(), context), 
              child: Text('Add item'), 
              style: ElevatedButton.styleFrom(primary: myBlue),), ) */
          ],
        ),
      ),
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
