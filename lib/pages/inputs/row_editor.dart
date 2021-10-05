import 'package:flutter/material.dart';
import 'package:tba/data/models.dart';
import 'package:tba/services/date_time_helper.dart';
import 'package:tba/styles/colors.dart';
import 'package:tba/shared/lists.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/services/router.dart';
import 'package:tba/services/preprocessor.dart';
import 'package:tba/pages/records/all.dart';

class RowEditorPage extends StatelessWidget {
  final Record rowData;
  const RowEditorPage({Key? key, required this.rowData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: setPageTitle(rowData.category),
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: setPageTitleBackgroundColor(rowData.category),
        ),
        body: Container(
          child: Center(
            child: RowEditorForm(initialFormData: rowData),
            /* child: Text(
                '${rowData.id}, ${rowData.createdAt}, ${rowData.category}, ${rowData.source}, ${rowData.amount}'), */
          ),
        ));
  }
}

setPageTitle(String? recordCategory) {
  if (recordCategory != null && recordCategory != '') {
    if (recordCategory == 'expenditure') {
      return Text('Edit expenditure');
    }
    if (recordCategory == 'income') {
      return Text('Edit income');
    }
  } else
    return Text('Nada');
}

setPageTitleBackgroundColor(String? recordCategory) {
  if (recordCategory != null && recordCategory != '') {
    if (recordCategory == 'expenditure') {
      return myRed;
    }
    if (recordCategory == 'income') {
      return myGreen;
    }
  } else
    return myBlue;
}

class RowEditorForm extends StatefulWidget {
  final Record initialFormData;
  const RowEditorForm({Key? key, required this.initialFormData})
      : super(key: key);

  @override
  _RowEditorFormState createState() => _RowEditorFormState();
}

class _RowEditorFormState extends State<RowEditorForm> {
  final _rowEditorFormKey = GlobalKey<FormState>();

  TextEditingController _amount = TextEditingController();
  // TextEditingController _source = TextEditingController();
  // TextEditingController _createdDateTime = TextEditingController();
  String? _category;
  String? _createdDateTime;
  String? _source;

  @override
  void initState() {
    super.initState();
    final data = widget.initialFormData;
    setState(() {
      _amount.text = data.amount.toString();
      _category = data.category;
      _createdDateTime = data.createdAt;
      _source = data.source;
      // print(data.category);
      print(data.createdAt);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _rowEditorFormKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              // margin: EdgeInsets.only(bottom: 20.0),
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: InputDatePickerFormField(
                  initialDate: DateTime.parse(_createdDateTime!),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2100)),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: DropdownButtonFormField(
                  value: _source,
                  // hint: Text('Reason for expenditure'),
                  decoration:
                      InputDecoration(labelText: 'Reason for expenditure'),
                  items: assignSourceList(_category),
                  validator: (val) => val == null
                      ? 'Please select reason for expenditure!'
                      : null,
                  onChanged: (val) => setState(() {
                    _source = val as String?;
                    // print('Exp name => $expenditureName');
                  }),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _amount,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter an amount!';
                    }
                  },
                  /* validator: (val) =>
                      val!.isEmpty ? 'Please enter an amount!' : null,
                  onChanged: (val) => setState(() {
                    expenditureAmount = val;
                  }), */
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
                      print('Tapped save button!');
                      /* if (_expenditureFormKey.currentState!.validate()) {
                        String parsedExpenditureAmount =
                            InputHandler().moneyCheck(expenditureAmount!);
                        SQLiteDatabaseHelper().insertRow('expenditure',
                            '$expenditureSource', '$parsedExpenditureAmount');
                        PageRouter().navigateToPage(AllRecords(), context);
                      } */
                    },
                    child: Text('SAVE'),
                    style: ElevatedButton.styleFrom(primary: setSaveButtonColor(_category)),
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

assignSourceList(String? editCategory) {
  if (editCategory == 'expenditure') {
    return MyItemList().expenditureList;
  }
  if (editCategory == 'income') {
    return MyItemList().incomeList;
  } else {
    return null;
  }
}

setSaveButtonColor(String? editCategory) {
  if (editCategory == 'expenditure') {
    return myRed;
  }
  if (editCategory == 'income') {
    return myGreen;
  }
}
