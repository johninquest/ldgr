import 'package:flutter/material.dart';
import 'package:ldgr/shared/lists.dart';
import 'package:ldgr/styles/colors.dart';

class AddItemPage extends StatelessWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add item'),
        centerTitle: true,
      ),
      body: Center(child: AddItemForm()),
    );
  }
}

class AddItemForm extends StatefulWidget {
  const AddItemForm({Key? key}) : super(key: key);

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _itemFormKey = GlobalKey<FormState>();
  TextEditingController _itemCategoryMain = TextEditingController();
  TextEditingController _itemCategorySub = TextEditingController();
  TextEditingController _itemName = TextEditingController();
  String? _accountingArea;
  String? _businessArea;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: _itemFormKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(labelText: 'Select accounting area'),
                      items: MyItemList().accountList,
                      validator: (val) =>
                          val == null ? 'Please select accounting area!' : null,
                      onChanged: (val) => setState(() {
                        _accountingArea = val as String?;
                      }),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(labelText: 'Select business area'),
                      items: MyItemList().expenseAreaList,
                      validator: (val) =>
                          val == null ? 'Please select business area!' : null,
                      onChanged: (val) => setState(() {
                        _businessArea = val as String?;
                      }),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    margin: EdgeInsets.only(bottom: 5.0),
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      controller: _itemCategoryMain,
                      enabled: true,
                      decoration: InputDecoration(labelText: 'Item category'),
                      keyboardType: TextInputType.emailAddress,
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    margin: EdgeInsets.only(bottom: 5.0),
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      controller: _itemCategorySub,
                      enabled: true,
                      decoration:
                          InputDecoration(labelText: 'Item sub-category'),
                      keyboardType: TextInputType.emailAddress,
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    margin: EdgeInsets.only(bottom: 5.0),
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      controller: _itemName,
                      enabled: true,
                      decoration: InputDecoration(labelText: 'Item name'),
                      keyboardType: TextInputType.emailAddress,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      child: ElevatedButton(
                        onPressed: () => print('Tapped save button'),
                        child: Text(
                          'SAVE',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(primary: myBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
