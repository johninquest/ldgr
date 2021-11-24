import 'package:flutter/material.dart';
import 'package:rba/services/date_time_helper.dart';
import 'package:rba/shared/snackbar_messages.dart';
import 'package:rba/styles/colors.dart';
import 'package:rba/shared/lists.dart';
import 'package:rba/db/sqlite_helper.dart';
import 'package:rba/services/router.dart';
import 'package:rba/services/preprocessor.dart';
import 'package:rba/pages/records/all.dart';

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
  TextEditingController expenseAmount = TextEditingController();
  TextEditingController expenseAdditionalDetail = TextEditingController();

  //Form values
  String? expenseCategory;
  String? expenseItem;
  String? paymentMethod;

  // String? expenseAdditionalDetail;
  // String? expenditureAmount;

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
                  decoration: InputDecoration(labelText: 'Expense category'),
                  items: MyItemList().expenseCategoryList,
                  validator: (val) =>
                      val == null ? 'Please select an expense category!' : null,
                  onChanged: (val) => setState(() {
                    expenseCategory = val as String?;
                  }),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Expense item'),
                  //items: MyItemList().expenseItemList,
                  items: setExpenseItemList(expenseCategory ?? ''),
                  validator: (val) =>
                      val == null ? 'Please select reason for expense!' : null,
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
                  decoration: InputDecoration(labelText: 'Additional detail'),
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please provide details!';
                    }
                  },
                  /* validator: (val) =>
                      val!.isEmpty ? 'Please enter an amount!' : null,
                  onChanged: (val) => setState(() {
                    expenseAdditionalDetail = val;
                  }), */
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: expenseAmount,
                  decoration: InputDecoration(labelText: 'Amount'),
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
                      val == null ? 'Please enter a payment method' : null,
                  onChanged: (val) => setState(() {
                    paymentMethod = val as String?;
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
                      print('Expense category => $expenseCategory');
                      print('Expense item => $expenseItem');
                      print(
                          'Expense detail => ${expenseAdditionalDetail.text}');
                      print('Expense item => ${expenseAmount.text}');
                      print('Payment method => $paymentMethod');
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
