import 'package:flutter/material.dart';
// import 'package:tba/styles/style.dart';
// import 'package:tba/services/router.dart';
import 'package:tba/shared/lists.dart';
import 'package:tba/data/sqlite_helper.dart'; 
import 'package:tba/data/shared_preferences_helper.dart';

class InputVehiclePage extends StatelessWidget {
  const InputVehiclePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter vehicle info'),
        centerTitle: true,
      ),
      body: Container(child: Center(child: VehicleForm(),),),
      
    );
  }
}

class VehicleForm extends StatefulWidget {
  const VehicleForm({ Key? key }) : super(key: key);

  @override
  _VehicleFormState createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
    final _formKey = GlobalKey<FormState>();

  String? incomeSource;
  String? incomeAmount;
  String? vehicleMaker; 
  String? vehicleModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: DropdownButtonFormField(
                    // dropdownColor: Colors.grey[200],
                    // style: TextStyle(color: Colors.greenAccent, ),
                    isExpanded: true,
                    hint: Text('Select maker'),
                    items: MyItemList().vehicleMakerList,
                    onChanged: (val) =>
                        setState(() => vehicleMaker = val as String?),
                  )
                  ),
                            Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Enter model'),
                    keyboardType: TextInputType.text,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter model!' : null,
                    onChanged: (val) => setState(() {
                      vehicleModel = val;
                      // print('The income amount => $val');
                    }),
                  )),    
              Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Price'),
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter car price!' : null,
                    onChanged: (val) => setState(() {
                      incomeAmount = val;
                      // print('The income amount => $val');
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
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // print('Income name => $incomeSource');
                        // print('Income amount => $incomeAmount');
                        // print('Timestamp => ${DateTimeHelper().timestampForDB()}');
                        SQLiteDatabaseHelper().insertRow(
                            'income', '$incomeSource', '$incomeAmount');
                        // PageRouter().navigateToPage(AllRecords(), context);
                      },
                      child: Text('SAVE'),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.blue[900]),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}