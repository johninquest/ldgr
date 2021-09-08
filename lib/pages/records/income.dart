import 'package:flutter/material.dart';

class IncomeRecords extends StatelessWidget {
  const IncomeRecords({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income list'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text('Income list!'),
        ),
      ),
    );
  }
}