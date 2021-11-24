import 'package:flutter/material.dart';
import 'package:rba/shared/lists.dart';
import 'package:rba/db/sqlite_helper.dart';
import 'package:rba/services/router.dart';
import 'package:rba/pages/records/all.dart';
import 'package:rba/shared/snackbar_messages.dart';
import 'package:rba/styles/colors.dart';
import 'package:rba/services/preprocessor.dart';
import 'package:rba/services/date_time_helper.dart';

class InputRevenuePage extends StatelessWidget {
  const InputRevenuePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter income'),
          centerTitle: true,
          backgroundColor: myGreen,
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