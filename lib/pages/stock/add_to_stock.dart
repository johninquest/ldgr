import 'package:flutter/material.dart';
import 'package:ldgr/db/sp_helper.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/pages/expense/expense_list.dart';
import 'package:ldgr/pages/stock/overview.dart';
import 'package:ldgr/services/date_time_helper.dart';
import 'package:ldgr/services/formatter.dart';
import 'package:ldgr/services/preprocessor.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/shared/dialogs.dart';
import 'package:ldgr/shared/lists.dart';
import 'package:ldgr/shared/snackbar_messages.dart';
import 'package:ldgr/styles/colors.dart';
import 'package:objectid/objectid.dart';

class AddToStockPage extends StatefulWidget {
  const AddToStockPage({Key? key}) : super(key: key);

  @override
  _AddToStockPageState createState() => _AddToStockPageState();
}

class _AddToStockPageState extends State<AddToStockPage> {
  final _addToStockFormKey = GlobalKey<FormState>();
  TextEditingController _pickedDate = TextEditingController();
  TextEditingController _itemName = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  String? _currentUser;
  String? _unit;

  DateTime selectedDate = DateTime.now();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new item to stock'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
              key: _addToStockFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /* Container(
                    margin: EdgeInsets.all(5.0),
                    child: Text(
                      'Still under construction!',
                      style:
                          TextStyle(color: myRed, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      // margin: EdgeInsets.only(bottom: 5.0),
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: 'What do you want to do?'),
                        items: MyItemList().storeOptionsList,
                        validator: (val) =>
                            val == null ? 'Please select add / remove?' : null,
                        onChanged: (val) => setState(() {
                          _entryType = val as String?;
                        }),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(labelText: 'Cost area'),
                        items: MyItemList().costAreaList,
                        validator: (val) =>
                            val == null ? 'Please select cost area' : null,
                        onChanged: (val) => setState(() {
                          _costArea = val as String?;
                        }),
                      )), */
                  Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      // margin: EdgeInsets.only(bottom: 5.0),
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        controller: _pickedDate,
                        enabled: true,
                        readOnly: true,
                        decoration: InputDecoration(labelText: 'Date'),
                        onTap: () => _selectDate(context),
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      // margin: EdgeInsets.only(bottom: 5.0),
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        controller: _itemName,
                        enabled: true,
                        decoration: InputDecoration(labelText: 'Item name'),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please enter quantity!';
                          }
                        },
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.50,
                          margin: EdgeInsets.only(left: 5.0),
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
                          width: MediaQuery.of(context).size.width * 0.30,
                          margin: EdgeInsets.only(bottom: 5.0, right: 5.0),
                          padding: EdgeInsets.only(right: 20.0),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(labelText: 'Unit'),
                            items: MyItemList().unitList,
                            onChanged: (val) => setState(() {
                              _unit = val as String?;
                            }),
                          ),
                        )
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
                            String _timestampsString =
                                DateTimeHelper().timestampForDB(DateTime.now());
                            String _stockItemId = ObjectId().hexString;
                            Map<String, dynamic> _stockEntryData = {
                              'picked_date': '$selectedDate',
                              'item_name': _itemName.text,
                              'quantity': _quantity.text,
                              'unit': _unit ?? '',
                              'created_at': _timestampsString,
                              'last_update_at': '',
                              'doc_id': _stockItemId,
                              'entered_by': _currentUser ?? '',
                              'events': [],
                            };
                            final _fs = FirestoreService();
                            if (_addToStockFormKey.currentState!.validate()) {
                              _fs
                                  .addItemToStock(_stockItemId, _stockEntryData)
                                  .then((val) {
                                if (val == 'add-success') {
                                  SnackBarMessage().customSuccessMessage(
                                      'Added to stock successfully', context);
                                  PageRouter().navigateToPage(
                                      StockOverviewPage(), context);
                                } else {
                                  SnackBarMessage()
                                      .generalErrorMessage(context);
                                }
                              });
                            }
                          },
                          child: Text('SAVE'),
                          style: ElevatedButton.styleFrom(primary: myBlue),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
