import 'package:flutter/material.dart';
import 'package:tba/shared/lists.dart';
// import 'package:tba/styles/style.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/services/router.dart';
import 'package:tba/pages/records/all.dart';
import 'package:tba/styles/colors.dart';
import 'package:tba/services/preprocessor.dart';
import 'package:tba/services/date_time_helper.dart';

class InputIncomePage extends StatelessWidget {
  const InputIncomePage({Key? key}) : super(key: key);

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
  final _incomeFormKey = GlobalKey<FormState>();

  String? incomeSource;
  String? incomeAmount;

  @override
  Widget build(BuildContext context) {
    DateTime moment = DateTime.now();
    return Container(
      child: Form(
        key: _incomeFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
              margin: EdgeInsets.only(bottom: 20.0),
              padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
              child: Text(DateTimeHelper().dateInWords(moment), style: TextStyle(fontWeight: FontWeight.bold, color: myGreen, fontSize: 18.0),),
            ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95, 
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: DropdownButtonFormField(
                    isExpanded: true, 
                    decoration: InputDecoration(labelText: 'Source of income'),
                    // hint: Text('Source of income'),
                    items: MyItemList().incomeList,
                    validator: (val) => val == null
                      ? 'Please select source of income!'
                      : null,
                    onChanged: (val) =>
                        setState(() => incomeSource = val as String?),
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0), 
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter an amount!' : null,
                    onChanged: (val) => setState(() {
                      incomeAmount = val;
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
                        if (_incomeFormKey.currentState!.validate()) {
                          String parsedIncomeAmount =
                            InputHandler().moneyCheck(incomeAmount!);
                        SQLiteDatabaseHelper().insertRow('income',
                          '$incomeSource', parsedIncomeAmount).then((value) {
                            if(value != null) {
                              PageRouter().navigateToPage(AllRecords(), context);
                            }
                          }); 
                      }
                      },
                      child: Text('SAVE'),
                      style:
                          ElevatedButton.styleFrom(primary: myGreen),
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