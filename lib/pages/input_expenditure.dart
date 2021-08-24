import 'package:flutter/material.dart';
import 'package:tba/styles/style.dart';
// import 'package:tba/services/router.dart';

class InputExpenditurePage extends StatelessWidget {
  // const InputExpenditure({ Key? key })//  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Enter expenditure'),
          centerTitle: true, 
          backgroundColor: Colors.redAccent,
        ),
        body: Center(
          child: ExpenditureForm(),
          /* child: Container(
            child: Text('Enter expenditure!'),
          ), */
        ));
  }
}

class ExpenditureForm extends StatefulWidget {
  const ExpenditureForm({Key? key}) : super(key: key);

  @override
  _ExpenditureFormState createState() => _ExpenditureFormState();
}

class _ExpenditureFormState extends State<ExpenditureForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> expenditureList = [
    'Damage repair',
    'Drink',
    'Food',
    'Fuel',
    'Maintenance',
    'Park fee',
    'Police control',
    'Tollgate', 
    'Other',
  ];

  //Form values
  String? expenditureName;
  String? expenditureAmount;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: DropdownButtonFormField(
                hint: Text('Select reason for expenditure'),
                items: expenditureList
                    .map((e) => DropdownMenuItem(value: e, child: Text('$e', style: ListItemStyle,)))
                    .toList(),
                onChanged: (val) =>
                    setState(() => expenditureName = val as String?),
              )),
          Container(
            margin: EdgeInsets.only(bottom: 10.0),
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: 'Enter amount'),
              keyboardType: TextInputType.number,
              validator: (val) => val!.isEmpty ? 'Please enter an amount!' : null,
              onChanged: (val) => setState(() { 
                expenditureAmount = val;
                print('The expenditure amount => $val');
            }),
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
                  ),),),
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    print('Expenditure name => $expenditureName'); 
                    print('Expenditure amount => $expenditureAmount');
                  },
                child: Text('SAVE'), 
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent
                ),), 
              ) 
              
            ],
          ),
         
        ],
      ),
    );
  }
}
