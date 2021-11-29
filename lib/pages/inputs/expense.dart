import 'package:flutter/material.dart';
import 'package:ldgr/firebase/firestore.dart';
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
  final _expenseFormKey = GlobalKey<FormState>();
  TextEditingController _itemCategory = TextEditingController();
  TextEditingController _itemName = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  //Form values
  // String? expenseCategory;
  String? _costArea;
  String? _unit;
  String? _paymentMethod;

  @override
  Widget build(BuildContext context) {
    DateTime moment = DateTime.now();
    return Form(
      key: _expenseFormKey,
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
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _itemCategory,
                  decoration: InputDecoration(labelText: 'Item category'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter item category!';
                    }
                  },
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _itemName,
                  decoration: InputDecoration(labelText: 'Item name'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter item name!';
                    }
                  },
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _price,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter price!';
                    }
                  },
                )),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    margin: EdgeInsets.only(right: 10.0),
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextFormField(
                      controller: _quantity,
                      decoration: InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter quantity!';
                        }
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    margin: EdgeInsets.only(left: 10.0, bottom: 5.0),
                    padding: EdgeInsets.only(right: 20.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(labelText: 'Unit'),
                      items: MyItemList().measurementUnitList,
                      /* validator: (val) =>
                          val == null ? 'Please select unit!' : null, */
                      onChanged: (val) => setState(() {
                        _unit = val as String?;
                      }),
                    ),
                  )
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Payment method'),
                  items: MyItemList().paymentMethodList,
                  validator: (val) =>
                      val == null ? 'Please select payment method' : null,
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
                      DateTime ts = DateTime.now();
                      Map<String, dynamic> _fsPayload = {
                        'account': 'expense',
                        'cost_area': _costArea ?? '',
                        'item_category': _itemCategory.text,
                        'item_name': _itemName.text,
                        'price': _price.text,
                        'quantity': _quantity.text,
                        'unit': _unit ?? '',
                        'payment_method': _paymentMethod ?? '',
                        'created_at': DateTimeHelper().timestampForDB(ts)
                      };
                      print(_fsPayload);
                      FirestoreService().saveDoc(_fsPayload);
                      // if (_expenseFormKey.currentState!.validate()) {}

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
  } else {
    return MyItemList().emptyList;
  }
}
