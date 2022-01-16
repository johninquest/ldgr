import 'package:flutter/material.dart';

class AddInventoryPage extends StatefulWidget {
  const AddInventoryPage({ Key? key }) : super(key: key);

  @override
  _AddInventoryPageState createState() => _AddInventoryPageState();
}

class _AddInventoryPageState extends State<AddInventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add inventory'),
        centerTitle: true,
      ),
      body: Center(child: Text('Under construction!'),),
    );
  }
}