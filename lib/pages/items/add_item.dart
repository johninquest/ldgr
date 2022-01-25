import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _itemFormKey = GlobalKey<FormState>();
  TextEditingController _costArea = TextEditingController();
  TextEditingController _itemCategory = TextEditingController();
  TextEditingController _itemName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _itemFormKey, 
      child: Center(child: Column(children: [
        Container(
                width: MediaQuery.of(context).size.width * 0.90,
                /* margin: EdgeInsets.only(bottom: 10.0, top: 40.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0), */
                child: TextFormField(
                  controller: _costArea,
                  decoration: InputDecoration(labelText: 'Cost area'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter cost area!';
                    }
                  },
                )),
                 Container(
                width: MediaQuery.of(context).size.width * 0.90,
                /* margin: EdgeInsets.only(bottom: 10.0, top: 40.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0), */
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
                width: MediaQuery.of(context).size.width * 0.90,
                /* margin: EdgeInsets.only(bottom: 10.0, top: 40.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0), */
                child: TextFormField(
                  controller: _itemName,
                  decoration: InputDecoration(labelText: 'Item name'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter item name!';
                    }
                  },
                )),

      ],),),
    );
  }
}
