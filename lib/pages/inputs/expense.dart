import 'package:flutter/material.dart';
import 'package:ldgr/services/date_time_helper.dart';
import 'package:ldgr/shared/snackbar_messages.dart';
import 'package:ldgr/styles/colors.dart';
import 'package:ldgr/shared/lists.dart';
import 'package:ldgr/db/sqlite_helper.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/services/preprocessor.dart';
import 'package:ldgr/pages/records/all.dart';

class InputExpenditurePage extends StatelessWidget {
  // const InputExpenditure({ Key? key })//  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter expense'),
          centerTitle: true,
          backgroundColor: myRed,
        ),
        body: Center(
          child: ExpenditureForm(),
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
  TextEditingController _expenseAmount = TextEditingController();

  //Form values
  // String? expenseCategory;
  String? _expenseItem;
  String? _paymentMethod;

  @override
  Widget build(BuildContext context) {
    DateTime moment = DateTime.now();
    return Form(
      key: _expenditureFormKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
              child: Text(
                DateTimeHelper().dateInWords(moment),
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: myRed, fontSize: 18.0),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Select item'),
                  items: MyItemList().expenseAreaList,
                  validator: (val) =>
                      val == null ? 'Please select expense category!' : null,
                  onChanged: (val) => setState(() {
                    _expenseItem = val as String?;
                  }),
                )),
            /* Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Item category'),
                  //items: MyItemList().expenseItemList,
                  items: setExpenseItemList(expenseCategory ?? ''),
                  validator: (val) =>
                      val == null ? 'Please select item category!' : null,
                  onChanged: (val) => setState(() {
                    expenseItem = val as String?;
                  }),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: expenseAdditionalDetail,
                  decoration: InputDecoration(labelText: 'Item name'),
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please provide item name!';
                    }
                  },
                  /* validator: (val) =>
                      val!.isEmpty ? 'Please enter an amount!' : null,
                  onChanged: (val) => setState(() {
                    expenseAdditionalDetail = val;
                  }), */
                )), */
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _expenseAmount,
                  decoration: InputDecoration(labelText: 'Enter amount'),
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter amount!';
                    }
                  },
                )),
                Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Payment method'),
                  items: MyItemList().paymentMethodList,
                  validator: (val) =>
                      val == null ? 'Please select a payment method' : null,
                  onChanged: (val) => setState(() {
                    _paymentMethod = val as String?;
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
                      print('Expense item => $_expenseItem');
                      print('Expense item => ${_expenseAmount.text}');
                      print('Payment method => $_paymentMethod');
                      /* if (_expenditureFormKey.currentState!.validate()) {
                        String parsedExpenditureAmount =
                            InputHandler().moneyCheck(expenditureAmount!);
                        SQLiteDatabaseHelper()
                            .insertRow('expenditure', '$expenditureSource',
                                '$parsedExpenditureAmount')
                            .then((value) {
                          if (value != null) {
                            SnackBarMessage().saveSuccess(context);
                            PageRouter().navigateToPage(AllRecords(), context);
                          }
                        });
                      } */
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

setExpenseItemList(String category) {
    if (category == 'bar') {
      return MyItemList().barItemList;
    }
    if (category == 'kitchen') {
      return MyItemList().kitchenItemList;
    }
    if (category == 'operating_costs') {
      return MyItemList().operatingCostsItemList;
    }
    if (category == 'toilet') {
      return MyItemList().toiletItemList;
    }
    if (category == 'others') {
      return MyItemList().othersItemList;
    }
     else {
      return MyItemList().emptyList;
    }
}
