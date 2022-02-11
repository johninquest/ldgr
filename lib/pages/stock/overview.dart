import 'package:flutter/material.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/pages/stock/add_to_stock.dart';
import 'package:ldgr/pages/stock/stock_item_details.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/shared/dialogs.dart';
import 'package:ldgr/shared/widgets.dart';
import 'package:ldgr/styles/colors.dart';

class StockOverviewPage extends StatelessWidget {
  const StockOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _fsQuery = FirestoreService().getSubCollection('records', 'stock');
    return Scaffold(
      appBar: AppBar(
        title: Text('Items in stock'),
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
/*       floatingActionButton: Container(
          decoration: BoxDecoration(
              color: myBlue,
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: IconButton(
              onPressed: () =>
                  PageRouter().navigateToPage(AddInventoryPage(), context),
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))), */
      bottomNavigationBar: BottomNavBar(),
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
  TextEditingController _quantityTaken = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List itemsInStock = widget.stockData;
    return ListView.builder(
        itemCount: itemsInStock.length,
        itemBuilder: (context, index) {
          String itemName = itemsInStock[index]['item_name'];
          String itemQuantity = itemsInStock[index]['quantity'];
          return Card(
            child: ExpansionTile(
              initiallyExpanded: false,
              // leading: Text(itemName),
              title: Text(
                itemName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // subtitle: Text(itemQuantity, style: TextStyle(fontWeight: FontWeight.bold),),
              /* trailing: Text(
                itemQuantity,
                style: TextStyle(fontWeight: FontWeight.bold),
              ), */
              //  onTap: () => print(itemsInStock[index]),
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Initial',
                      ),
                      Text(
                        itemQuantity,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Remaining',
                      ),
                      Text(
                        _subtraction(itemQuantity),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: ElevatedButton(
                        onPressed: () => print('Tapped delete button!'),
                        child: Text('DELETE'),
                        style: ElevatedButton.styleFrom(primary: myRed),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: ElevatedButton(
                          onPressed: () => showDialog(
                              context: context,
                              builder: (_) => _takeFromStockDialog(itemName)),
                          child: Text('TAKE')),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
              ],
            ),
          );
        });
  }

  Widget _takeFromStockDialog(String currentItemName) {
    return AlertDialog(
/*       title: Icon(
        Icons.info,
        color: myBlue,
      ), */
      content: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Taking ${currentItemName.toLowerCase()} from stock?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: myBlue, fontSize: 20.0),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.only(top: 20.0),
              child: TextField(
                controller: _quantityTaken,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
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
                  print('Tapped the yes button!');
                  print('Quantity taken => ${_quantityTaken.text}');
                },
                child: Text(
                  'YES',
                  style: TextStyle(color: myBlue, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
    );
  }
}

_subtraction(String iniValue) {
  int valToInt = int.parse(iniValue);
  return (valToInt - 2).toString();
}
