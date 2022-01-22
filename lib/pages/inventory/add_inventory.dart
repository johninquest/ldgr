import 'package:flutter/material.dart';
import 'package:ldgr/shared/lists.dart';
import 'package:ldgr/styles/colors.dart';

class AddInventoryPage extends StatefulWidget {
  const AddInventoryPage({Key? key}) : super(key: key);

  @override
  _AddInventoryPageState createState() => _AddInventoryPageState();
}

class _AddInventoryPageState extends State<AddInventoryPage> {
  final _inventoryFormKey = GlobalKey<FormState>();
  TextEditingController _itemCategory = TextEditingController();
  TextEditingController _itemName = TextEditingController();
  TextEditingController _quantity = TextEditingController();
  TextEditingController _price = TextEditingController();
  String? _entryType;
  String? _costArea;
  String? _unit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add / remove stock'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
              key: _inventoryFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      // margin: EdgeInsets.only(bottom: 5.0),
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: 'Add / remove stock'),
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
                      )),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      // margin: EdgeInsets.only(bottom: 5.0),
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        controller: _itemCategory,
                        enabled: true,
                        decoration: InputDecoration(labelText: 'Item category'),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
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
                      width: MediaQuery.of(context).size.width * 0.90,
                      // margin: EdgeInsets.only(bottom: 10.0),
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
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
                          onPressed: () => print('Tapped save button!'),
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
