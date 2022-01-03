import 'package:flutter/material.dart';
import 'package:ldgr/db/sp_helper.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/pages/records/expense_list.dart';
import 'package:ldgr/services/date_time_helper.dart';
import 'package:ldgr/styles/colors.dart';
import 'package:ldgr/shared/lists.dart';
import 'package:ldgr/shared/snackbar_messages.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/services/preprocessor.dart';
import 'package:ldgr/services/formatter.dart';

class EntryEditorPage extends StatelessWidget {
  final Map entryData;
  const EntryEditorPage({Key? key, required this.entryData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update expense'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: EntryEditorForm(
          initialData: entryData,
        ),
      ),
    );
  }
}

class EntryEditorForm extends StatefulWidget {
  final Map initialData;
  const EntryEditorForm({Key? key, required this.initialData})
      : super(key: key);

  @override
  _EntryEditorFormState createState() => _EntryEditorFormState();
}

class _EntryEditorFormState extends State<EntryEditorForm> {
  final _expenseUpdateFormKey = GlobalKey<FormState>();
  TextEditingController _itemCategory = TextEditingController();
  TextEditingController _itemName = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _pickedDate = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  String? _docId;
  String? _costArea;
  String? _unit;
  String? _paymentMethod;
  String? _paymentStatus;
  String? _currentUser;

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
    _docId = widget.initialData['doc_id'];
    selectedDate = DateTime.parse(widget.initialData['picked_date']);
    _pickedDate.text =
        DateTimeFormatter().isoToUiDate(widget.initialData['picked_date']);
    _costArea = widget.initialData['cost_area'];
    _itemCategory.text = widget.initialData['item_category'] ?? '';
    _itemName.text = widget.initialData['item_name'] ?? '';
    _quantity.text = widget.initialData['quantity'] ?? '';
    _unit = widget.initialData['unit'].toLowerCase() ?? '';
    _price.text = widget.initialData['price'] ?? '';
    _paymentStatus = widget.initialData['payment_status'];
    _paymentMethod = widget.initialData['payment_method'];
  }

  late DateTime selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _pickedDate.text = DateTimeFormatter().toDateString(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _expenseUpdateFormKey,
      child: SingleChildScrollView(
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
                  value: _costArea,
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
                      value: _unit ?? '',
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
                      value: _paymentStatus ?? '',
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
                      value: _paymentMethod ?? '',
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
                    child: Text('CANCEL'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      String _tsToString =
                          DateTimeHelper().timestampForDB(DateTime.now());
                      Map<String, dynamic> _fsUpdatePayload = {
                        'pickedDate': '$selectedDate',
                        'costArea': _costArea ?? '',
                        'itemCategory': _itemCategory.text,
                        'itemName': _itemName.text,
                        'quantity': _quantity.text,
                        'unit': _unit ?? '',
                        'price': _price.text,
                        'paymentStatus': _paymentStatus ?? '',
                        'paymentMethod': _paymentMethod ?? '',
                        'lastUpdateAt': _tsToString,
                        'enteredBy': _currentUser ?? '',
                      };
                      if (_expenseUpdateFormKey.currentState!.validate()) {
                        FirestoreService()
                            .updateDocument(_docId!, _fsUpdatePayload)
                            .then((val) {
                          SnackBarMessage().updateSuccess(context);
                          PageRouter().navigateToPage(EntryListPage(), context);
                        }).catchError((e) =>
                                SnackBarMessage().generalErrorMessage(context));
                        /* FirestoreService()
                            .updateDocument(_docId!, _fsUpdatePayload)
                            .then((val) {
                          if (val == 'add-success') {
                            SnackBarMessage().updateSuccess(context);
                            PageRouter()
                                .navigateToPage(EntryListPage(), context);
                          } else if (val == 'permission-denied') {
                            String eMessage = 'Permission denied';
                            return SnackBarMessage()
                                .customErrorMessage(eMessage, context);
                          } else {
                            return SnackBarMessage()
                                .generalErrorMessage(context);
                          }
                        }); */
                      }
                    },
                    child: Text('SAVE'),
                    style: ElevatedButton.styleFrom(primary: myBlue),
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
