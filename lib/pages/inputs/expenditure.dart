import 'package:flutter/material.dart';
import 'package:tba/styles/colors.dart';
import 'package:tba/shared/lists.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/services/router.dart';
import 'package:tba/pages/records/all.dart';

class InputExpenditurePage extends StatelessWidget {
  // const InputExpenditure({ Key? key })//  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter expenditure'),
          centerTitle: true,
          backgroundColor: myRed,
        ),
        body: Center(
          child: ExpenditureForm(),
          /* child: Container(
            child: Text('Enter expenditure!'),
          ), */
        ));
  }
}

class ExpenditureForm extends StatefulWidget {
  const ExpenditureForm({Key? key}) : super(key: key);

  @override
  _ExpenditureFormState createState() => _ExpenditureFormState();
}

class _ExpenditureFormState extends State<ExpenditureForm> {
  final _expenditureFormKey = GlobalKey<FormState>();

  //Form values
  String? expenditureSource;
  String? expenditureAmount;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _expenditureFormKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: DropdownButtonFormField(
                  hint: Text('Reason for expenditure'),
                  items: MyItemList().expenditureList,
                  validator: (val) => val == null
                      ? 'Please select reason for expenditure!'
                      : null,
                  onChanged: (val) => setState(() {
                    expenditureSource = val as String?;
                    // print('Exp name => $expenditureName');
                  }),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter an amount!' : null,
                  onChanged: (val) => setState(() {
                    expenditureAmount = val;
                  }),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('CANCEL'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      /* SQLiteDatabaseHelper().insertRow('expenditure',
                          '$expenditureName', '$expenditureAmount');
                      PageRouter().navigateToPage(AllRecords(), context); */
                      if (_expenditureFormKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Saving expenditure information...')),
                        );
                        SQLiteDatabaseHelper().insertRow('expenditure',
                          '$expenditureSource', '$expenditureAmount');
                        PageRouter().navigateToPage(AllRecords(), context);  
                      }
                    },
                    child: Text('SAVE'),
                    style: ElevatedButton.styleFrom(primary: myRed),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
