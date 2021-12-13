import 'package:flutter/material.dart';
import 'package:ldgr/shared/lists.dart';
import 'package:ldgr/db/sqlite_helper.dart';
import 'package:ldgr/shared/snackbar_messages.dart';
import 'package:ldgr/styles/colors.dart';
import 'package:ldgr/services/preprocessor.dart';
import 'package:ldgr/services/date_time_helper.dart';

class InputIncomePage extends StatelessWidget {
  const InputIncomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter income'),
          centerTitle: true,
          backgroundColor: myTeal,
        ),
        body: Center(
          child: Container(
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

  String? _costArea;
  String? incomeSource;
  String? incomeAmount;

  @override
  Widget build(BuildContext context) {
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
                child: Text(
                  DateTimeHelper().dateInWords(DateTime.now()),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: myTeal,
                      fontSize: 18.0),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(labelText: 'Cost area'),
                    items: MyItemList().costAreaList,
                    validator: (val) =>
                        val == null ? 'Please select cost area!' : null,
                    onChanged: (val) => setState(() {
                      _costArea = val as String?;
                    }),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: 'Source of income'),
                    // hint: Text('Source of income'),
                    items: MyItemList().emptyList,
                    validator: (val) =>
                        val == null ? 'Please select source of income!' : null,
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
                        val!.isEmpty ? 'Please enter amount!' : null,
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
                          SQLiteDatabaseHelper()
                              .insertRow(
                                  'income', '$incomeSource', parsedIncomeAmount)
                              .then((value) {
                            if (value != null) {
                              SnackBarMessage().saveSuccess(context);
                              /* PageRouter()
                                  .navigateToPage(AllRecords(), context); */
                            }
                          });
                        }
                      },
                      child: Text('SAVE'),
                      style: ElevatedButton.styleFrom(primary: myTeal),
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
