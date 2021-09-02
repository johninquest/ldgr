import 'package:flutter/material.dart';

class ExpenditureRecords extends StatelessWidget {
  const ExpenditureRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table Of Expenditures'),
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
