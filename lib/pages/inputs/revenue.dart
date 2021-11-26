import 'package:flutter/material.dart';
import 'package:ldgr/shared/lists.dart';
import 'package:ldgr/db/sqlite_helper.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/pages/records/all.dart';
import 'package:ldgr/shared/snackbar_messages.dart';
import 'package:ldgr/styles/colors.dart';
import 'package:ldgr/services/preprocessor.dart';
import 'package:ldgr/services/date_time_helper.dart';

class InputRevenuePage extends StatelessWidget {
  const InputRevenuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter revenue'),
          centerTitle: true,
          backgroundColor: myTeal,
        ),
        body: Center(
          child: Container(
            // child: Text('Enter income!'),
            child: RevenueForm(),
          ),
        ));
  }
}

class RevenueForm extends StatefulWidget {
  const RevenueForm({ Key? key }) : super(key: key);

  @override
  _RevenueFormState createState() => _RevenueFormState();
}

class _RevenueFormState extends State<RevenueForm> {
  final _revenueFormKey = GlobalKey<FormState>();

  String? revenueSource;
  String? revenueAmount;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Hallo welt!')
      
    );
  }
}