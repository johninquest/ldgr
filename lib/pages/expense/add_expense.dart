import 'package:flutter/material.dart';
import 'package:objectid/objectid.dart';
import 'dart:async';
import '../../db/sp_helper.dart';
import '../../firebase/firestore.dart';
import '../../services/date_time_helper.dart';
import '../../services/formatter.dart';
import '../../services/preprocessor.dart';
import '../../services/router.dart';
import '../../shared/lists.dart';
import '../../shared/snackbar_messages.dart';
import '../../styles/colors.dart';
import 'expense_list.dart';

class AddExpensePage extends StatelessWidget {
  const AddExpensePage({Key? key}) : super(key: key);

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
  TextEditingController _pickedDate = TextEditingController(
      text: DateTimeFormatter().toDateString(DateTime.now()));
  TextEditingController _quantity = TextEditingController();

  String? _costArea;
  String? _unit;
  String? _paymentMethod;
  String? _paymentStatus;
  String? _currentUser;

  final _fs = FirestoreService();

  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != currentDate)
      setState(() {
        currentDate = picked;
        _pickedDate.text = DateTimeFormatter().toDateString(picked);
        /*  print('Picked date => $_pickedDate'); */
      });
  }

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper().readData('currentUserData').then((value) {
      if (value != null) {
        setState(() {
          _currentUser = DataParser().strToMap(value)['name'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final _fs = FirestoreService();
    return Form(
      key: _expenseFormKey,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _pickedDate,
                  enabled: true,
                  readOnly: true,
                  decoration: InputDecoration(labelText: 'Date'),
                  onTap: () => _selectDate(context),
/*                   validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter item category!';
                    }
                  }, */
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Cost area'),
                  items: MyItemList().costAreaList,
                  validator: (val) =>
                      val == null ? 'Please select cost area' : null,
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
/*                   validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter item category!';
                    }
                  }, */
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
                      return 'Please enter item name';
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
/*                       validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter quantity!';
                        }
                      }, */
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    margin: EdgeInsets.only(left: 10.0, bottom: 5.0),
                    padding: EdgeInsets.only(right: 20.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(labelText: 'Unit'),
                      items: MyItemList().unitList,
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
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _price,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter price';
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    margin: EdgeInsets.only(right: 10.0),
                    padding: EdgeInsets.only(left: 15.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(labelText: 'Payment status'),
                      items: MyItemList().paymentStatusList,
                      validator: (val) =>
                          val == null ? 'Payment status ?' : null,
                      onChanged: (val) => setState(() {
                        _paymentStatus = val as String?;
                      }),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    margin: EdgeInsets.only(left: 10.0),
                    padding: EdgeInsets.only(right: 15.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(labelText: 'Payment method'),
                      items: MyItemList().paymentMethodList,
                      /* validator: (val) =>
                          val == null ? 'Please select payment method' : null, */
                      onChanged: (val) => setState(() {
                        _paymentMethod = val as String?;
                      }),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('CANCEL', style: TextStyle(letterSpacing: 1.0)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      String _timestampsString =
                          DateTimeHelper().timestampForDB(DateTime.now());
                      String _daybookItemId = ObjectId().hexString;
                      // print('Expense record id => $_daybookItemId');
                      Map<String, dynamic> _daybookEntryData = {
                        'picked_date': '$currentDate',
                        'account': 'expense',
                        'cost_area': _costArea ?? '',
                        'item_category': _itemCategory.text,
                        'item_name': _itemName.text,
                        'quantity': _quantity.text,
                        'unit': _unit ?? '',
                        'price': _price.text,
                        'payment_status': _paymentStatus ?? '',
                        'payment_method': _paymentMethod ?? '',
                        'created_at': _timestampsString,
                        'last_update_at': '',
                        'doc_id': _daybookItemId,
                        'entered_by': _currentUser ?? '',
                      };
                      if (_expenseFormKey.currentState!.validate()) {
                        _fs
                            .addItemToDaybook(_daybookItemId, _daybookEntryData)
                            .then((val) {
                          if (val == 'add-success') {
                            SnackBarMessage().saveSuccess(context);
                            if (_itemName.text != '' && _quantity.text != '') {
                              Timer(Duration(seconds: 3), () {
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        _addToStockDialog(_daybookItemId),
                                    barrierDismissible: true);
                              });
                            } else {
                              PageRouter()
                                  .navigateToPage(EntryListPage(), context);
                            }
                          } else if (val == 'permission-denied') {
                            String eMessage = 'Permission denied';
                            return SnackBarMessage()
                                .customErrorMessage(eMessage, context);
                          } else {
                            return SnackBarMessage()
                                .generalErrorMessage(context);
                          }
                        });
                      }
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(letterSpacing: 1.0),
                    ),
                    style: ElevatedButton.styleFrom(backgroundColor: myRed),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _addToStockDialog(String _daybookDocId) {
    return AlertDialog(
      title: Icon(
        Icons.help_outline,
        color: myBlue,
        size: 40.0,
      ),
      content: Text(
        'Add to stock ?',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: myBlue, fontSize: 20.0),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                PageRouter().navigateToPage(EntryListPage(), context);
              },
              child: Text(
                'NO',
                style: TextStyle(
                    color: myRed,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
            ),
            TextButton(
                onPressed: () {
                  String _timestampString =
                      DateTimeHelper().timestampForDB(DateTime.now());
                  String _stockItemId = ObjectId().hexString;
                  Map<String, dynamic> _stockEntryData = {
                    'picked_date': '$currentDate',
                    'item_name': _itemName.text,
                    'quantity': InputHandler().commaToPeriod(_quantity.text),
                    'unit': _unit ?? '',
                    'created_at': _timestampString,
                    'last_update_at': '',
                    'doc_id': _stockItemId,
                    'daybook_item_id': _daybookDocId,
                    'entered_by': _currentUser ?? '',
                    'events': []
                  };
                  _fs.addItemToStock(_stockItemId, _stockEntryData).then((val) {
                    if (val == 'add-success') {
                      SnackBarMessage().customSuccessMessage(
                          'Added to stock successfully', context);
                      PageRouter().navigateToPage(EntryListPage(), context);
                    } else {
                      SnackBarMessage().generalErrorMessage(context);
                    }
                  });
                },
                child: Text(
                  'YES',
                  style: TextStyle(
                      color: myGreen,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ))
          ],
        ),
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}
