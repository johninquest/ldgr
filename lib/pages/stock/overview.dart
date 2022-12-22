import 'package:flutter/material.dart';
import '../../db/sp_helper.dart';
import '../../firebase/firestore.dart';
import '../../utils/date_time_helper.dart';
import '../../utils/formatter.dart';
import '../../utils/preprocessor.dart';
import '../../utils/router.dart';
import '../../shared/bottom_nav_bar.dart';
import '../../shared/custom_widgets.dart';
import '../../shared/snackbar_messages.dart';
import '../../styles/colors.dart';
import 'add_to_stock.dart';
import 'calculations.dart';
import 'stock_item_details.dart';

class StockOverviewPage extends StatelessWidget {
  const StockOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _fsQuery = FirestoreService().getSubCollection('records', 'stock');
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock list'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _fsQuery,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorOccured();
            }
            if (snapshot.hasData) {
              List resData = snapshot.data as List;
              return StockOverviewData(stockData: resData);
            } else {
              return WaitingForResponse();
            }
          }),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: Tooltip(
          message: 'Add new item to stock',
          child: IconButton(
            icon: Icon(
              Icons.add_circle,
              /*  color: myBlueLighter, */
              size: 40.0,
            ),
            onPressed: () =>
                PageRouter().navigateToPage(AddToStockPage(), context),
          )),
    );
  }
}

class StockOverviewData extends StatefulWidget {
  final List stockData;
  const StockOverviewData({Key? key, required this.stockData})
      : super(key: key);

  @override
  _StockOverviewDataState createState() => _StockOverviewDataState();
}

class _StockOverviewDataState extends State<StockOverviewData> {
  final _logsFormKey = GlobalKey<FormState>();
  TextEditingController _quantityAdded = TextEditingController();
  TextEditingController _quantityTaken = TextEditingController();
  String? _currentUserName;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper().readData('currentUserData').then((value) {
      if (value != null) {
        setState(() {
          _currentUserName = DataParser().strToMap(value)['name'];
        });
        String userRole = DataParser().strToMap(value)['role'] ?? '';
        if (userRole == 'owner' || userRole == 'admin') {
          setState(() {
            _isVisible = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List itemsInStock = widget.stockData;
    return ListView.builder(
        itemCount: itemsInStock.length,
        itemBuilder: (context, index) {
          String _itemId = itemsInStock[index]['doc_id'] ?? '';
          String _itemName = itemsInStock[index]['item_name'] ?? '';
          String _itemInitialQty = itemsInStock[index]['quantity'] ?? '';
          String _itemDate = itemsInStock[index]['picked_date'] ?? '';
          List _eventLogs = itemsInStock[index]['events'] ?? [];
          var _calculator = StockCalculations();
          num _availableQty = _calculator.computeRemainingItems(
              _itemInitialQty,
              _calculator.sumOfAddedItems(_eventLogs),
              _calculator.sumOfRemovedItems(_eventLogs));
          return Card(
            child: ExpansionTile(
              initiallyExpanded: false,
              leading: Text(
                DateTimeFormatter().isoToUiDate(_itemDate),
                style: TextStyle(
                    fontSize: 15.0,
                    color: setExpansionTileColor(_availableQty)),
              ),
              title: Text(
                _itemName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: setExpansionTileColor(_availableQty)),
              ),
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Available',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$_availableQty',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 25.0,
                  endIndent: 25.0,
                  thickness: 1.0,
                  color: myBlue,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                            child: ElevatedButton(
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (_) => _removeFromStockDialog(
                                        _itemId, _itemName)),
                                child: Tooltip(
                                    message: 'Take from this stock',
                                    child: Text('TAKE'))),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
                            child: ElevatedButton(
                                onPressed: () => PageRouter().navigateToPage(
                                    StockItemDetails(
                                      stockItemData: itemsInStock[index],
                                    ),
                                    context),
                                child: Text('DETAILS')),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: _isVisible,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: ElevatedButton(
                                onPressed: () => showDialog(
                                    context: context,
                                    builder: (_) =>
                                        _deleteDialog(_itemId, _itemName)),
                                child: Text('DELETE'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: myRed),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: ElevatedButton(
                                  onPressed: () => showDialog(
                                      context: context,
                                      builder: (_) => _addToStockDialog(
                                          _itemId, _itemName)),
                                  child: Tooltip(
                                      message: 'Add to this stock',
                                      child: Text('ADD'))),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _removeFromStockDialog(String _currentDocId, String _currentItemName) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Taking "$_currentItemName" from stock?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: myBlue,
                ),
              ),
            ),
            Form(
              key: _logsFormKey,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                margin: EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  controller: _quantityTaken,
                  decoration: InputDecoration(labelText: 'Enter quantity'),
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter quantity' : null,
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                _quantityTaken.clear();
                Navigator.of(context).pop();
              },
              child: Text(
                'CANCEL',
                style: TextStyle(color: myGrey, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
                onPressed: () {
                  if (_logsFormKey.currentState!.validate()) {
                    var _fs = FirestoreService();
                    String _tsToString =
                        DateTimeHelper().timestampForDB(DateTime.now());
                    List<Map<String, String>> _fsUpdatePayload = [
                      {
                        'event_timestamp': _tsToString,
                        'event_quantity':
                            InputHandler().commaToPeriod(_quantityTaken.text),
                        'event_name': 'removed_from_stock',
                        'event_by': _currentUserName ?? '',
                      }
                    ];

                    _fs
                        .updateArrayInDocument(
                            _currentDocId, 'events', _fsUpdatePayload)
                        .then((val) {
                      SnackBarMessage()
                          .customSuccessMessage('Logged successfully', context);
                      PageRouter().navigateToPage(StockOverviewPage(), context);
                    });
                  }
                },
                child: Text(
                  'SAVE',
                  style: TextStyle(color: myBlue, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }

  Widget _addToStockDialog(String _currentDocId, String _currentItemName) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Adding "$_currentItemName" to stock?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: myBlue,
                ),
              ),
            ),
            Form(
              key: _logsFormKey,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                margin: EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  controller: _quantityAdded,
                  decoration: InputDecoration(labelText: 'Enter quantity'),
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter quantity' : null,
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                _quantityTaken.clear();
                Navigator.of(context).pop();
              },
              child: Text(
                'CANCEL',
                style: TextStyle(color: myGrey, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
                onPressed: () {
                  if (_logsFormKey.currentState!.validate()) {
                    var _fs = FirestoreService();
                    String _tsToString =
                        DateTimeHelper().timestampForDB(DateTime.now());
                    List<Map<String, String>> _fsUpdatePayload = [
                      {
                        'event_timestamp': _tsToString,
                        'event_quantity':
                            InputHandler().commaToPeriod(_quantityAdded.text),
                        'event_name': 'added_to_stock',
                        'event_by': _currentUserName ?? '',
                      }
                    ];
                    _fs
                        .updateArrayInDocument(
                            _currentDocId, 'events', _fsUpdatePayload)
                        .then((val) {
                      SnackBarMessage()
                          .customSuccessMessage('Logged successfully', context);
                      PageRouter().navigateToPage(StockOverviewPage(), context);
                    });
                  }
                },
                child: Text(
                  'SAVE',
                  style: TextStyle(color: myBlue, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }

  Widget _deleteDialog(String _stockItemId, String _stockItemName) {
    return AlertDialog(
      title: Icon(
        Icons.warning,
        color: myRed,
        size: 40.0,
      ),
      content: Text(
        'Delete ? \n"$_stockItemName"',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: myBlue, fontSize: 20.0),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'NO',
                style: TextStyle(color: myRed, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
                onPressed: () {
                  FirestoreService()
                      .removeDocFromSubCollection(
                          'records', 'stock', _stockItemId)
                      .then((val) {
                    SnackBarMessage().deleteSuccess(context);
                    PageRouter().navigateToPage(StockOverviewPage(), context);
                  }).catchError((e) =>
                          SnackBarMessage().generalErrorMessage(context));
                },
                child: Text(
                  'YES',
                  style: TextStyle(color: myGreen, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}

setExpansionTileColor(num qAvailable) {
  if (qAvailable <= 0) {
    Color _color = myRed;
    return _color;
  } else {
    return Colors.black;
  }
}
