import 'package:flutter/material.dart';
import 'package:objectid/objectid.dart';
import '../../db/sp_helper.dart';
import '../../firebase/firestore.dart';
import '../../utils/date_time_helper.dart';
import '../../utils/formatter.dart';
import '../../utils/preprocessor.dart';
import '../../utils/router.dart';
import '../../shared/lists.dart';
import '../../shared/snackbar_messages.dart';
import '../../styles/colors.dart';
import 'overview.dart';

class AddToStockPage extends StatefulWidget {
  const AddToStockPage({Key? key}) : super(key: key);

  @override
  _AddToStockPageState createState() => _AddToStockPageState();
}

class _AddToStockPageState extends State<AddToStockPage> {
  final _addToStockFormKey = GlobalKey<FormState>();
  TextEditingController _pickedDate = TextEditingController(
      text: DateTimeFormatter().toDateString(DateTime.now()));
  TextEditingController _itemName = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  String? _currentUser;
  String? _unit;

  DateTime currentDateTime = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDateTime,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != currentDateTime)
      setState(() {
        currentDateTime = picked;
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
                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                                letterSpacing: 1.0, color: blackColor),
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
                              'picked_date': '$currentDateTime',
                              'item_name': _itemName.text,
                              'quantity':
                                  InputHandler().commaToPeriod(_quantity.text),
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
                          child: Text(
                            'SAVE',
                            style: TextStyle(letterSpacing: 1.0),
                          ),
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
