import 'package:flutter/material.dart';
import 'package:tba/shared/lists.dart';
// import 'package:tba/styles/style.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/services/time.dart';
import 'package:tba/services/router.dart';
import 'package:tba/pages/all_records.dart';

class InputIncomePage extends StatelessWidget {
  const InputIncomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter income'),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
        body: Center(
          child: Container(
            // child: Text('Enter income!'),
            child: IncomeForm(),
          ),
        ));
  }
}

class IncomeForm extends StatefulWidget {
  const IncomeForm({Key? key}) : super(key: key);

  @override
  _IncomeFormState createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final _formKey = GlobalKey<FormState>();

  String? incomeSource;
  String? incomeAmount;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: DropdownButtonFormField(
                    // dropdownColor: Colors.grey[200],
                    // style: TextStyle(color: Colors.greenAccent, ),
                    isExpanded: true,
                    hint: Text('Select source of income'),
                    items: MyItemList().incomeList,
                    onChanged: (val) =>
                        setState(() => incomeSource = val as String?),
                  )),
              Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Enter amount'),
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter an amount!' : null,
                    onChanged: (val) => setState(() {
                      incomeAmount = val;
                      // print('The income amount => $val');
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
                        print('Income name => $incomeSource');
                        print('Income amount => $incomeAmount');
                        // print('Timestamp => ${DateTimeHelper().timestampForDB()}');
                        SQLiteDatabaseHelper().insertRow(
                            'income', '$incomeSource', '$incomeAmount');
                        PageRouter().navigateToPage(AllRecordsPage(), context);
                      },
                      child: Text('SAVE'),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.greenAccent),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}