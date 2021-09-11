import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:tba/styles/style.dart';
import 'package:tba/shared/lists.dart';
import 'package:tba/services/date_time_helper.dart';
// import 'package:tba/data/sqlite_helper.dart';
// import 'package:tba/data/shared_preferences_helper.dart';

class InputVehiclePage extends StatelessWidget {
  const InputVehiclePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter vehicle info'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: VehicleForm(),
        ),
      ),
    );
  }
}

class VehicleForm extends StatefulWidget {
  const VehicleForm({Key? key}) : super(key: key);

  @override
  _VehicleFormState createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
  final _formKey = GlobalKey<FormState>();

  String? incomeSource;
  String? incomeAmount;
  String? vehicleMaker;
  String? vehicleModel;
  String? vehicleFirstRegistrationDate;
  // String? vehicleAge = 'Helo';
  String? vehiclePrice;

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
      });
  }

/*   late TextEditingController vehicleFirstRegistrationDate =
      TextEditingController(text: '$selectedDate'); */

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
                  )),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250.0,
                      margin: EdgeInsets.only(right: 5.0),
                      child: TextFormField(
                        // enabled: true,
                        readOnly: true,
                        // controller: vehicleFirstRegistrationDate, 
                        decoration: InputDecoration(
                            hintText: initialDateHandler(selectedDate), prefixIcon: Icon(Icons.calendar_today_outlined, size: 25.0,)), 
                        // keyboardType: TextInputType.datetime,
                        onTap: () => _selectDate(context), 
/*                           validator: (val) => val!.isEmpty
                              ? 'Please enter first registration date!'
                              : null, 
                          onChanged: (val) => setState(() {
                                print(val);
                                vehicleFirstRegistrationDate.text = val;
                              }), */
                      ),
                    ),
                    Container(
                      width: 80.0,
                      margin: EdgeInsets.only(left: 5.0),
                      child: TextFormField(
                        enabled: false,
                        // initialValue: vehicleAge,
                        decoration: InputDecoration(
                            hintText:
                                DateTimeHelper().ageFromDate(selectedDate)),
                        // keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Purchase price ?'),
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter vehicle price!' : null,
                    onChanged: (val) => setState(() {
                      vehiclePrice = val;
                      print('Vehicle price => $val');
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
                        // SQLiteDatabaseHelper().insertRow('income', '$incomeSource', '$incomeAmount');
                        // PageRouter().navigateToPage(AllRecords(), context);
                        print('Pressed save button!');
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

initialDateHandler(DateTime dt) {
  DateTime today = DateTime.now();
  DateFormat toDateFormat = DateFormat('yyyy-MM-dd');
  DateFormat cmrDateFormat = DateFormat('dd/MM/yyyy');
  String toCmrDateFormat = cmrDateFormat.format(dt);
  String todayFormatted = toDateFormat.format(today);
  String dtFormatted = toDateFormat.format(dt);
  if (dtFormatted == todayFormatted) {
    return 'First registration date ?';
  } else {
    return toCmrDateFormat;
  }
}
