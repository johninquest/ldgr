import 'package:flutter/material.dart';

class ExpenditureRecords extends StatelessWidget {
  const ExpenditureRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenditure list'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text('Expenditure list!'),
        ),
      ),
    );
  }
}
