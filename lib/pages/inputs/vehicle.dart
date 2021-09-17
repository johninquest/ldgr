import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tba/services/router.dart';
import 'dart:convert';
// import 'package:tba/styles/style.dart';
import 'package:tba/shared/lists.dart';
import 'package:tba/services/date_time_helper.dart';
import 'package:tba/data/sp_helper.dart';
import 'package:tba/pages/stored_vehicle.dart';

class InputVehiclePage extends StatelessWidget {
  const InputVehiclePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter vehicle infos'),
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
  final _vehicleFormKey = GlobalKey<FormState>();

  String? vehiclePlateNumber;
  String? vehicleChassisNumber;
  String? vehicleMaker;
  String? vehicleModel;
  String? vehicleFirstRegistrationDate;
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
        vehicleFirstRegistrationDate = storedDateHandler(picked);
      });
  }

  String? storedVehicleData;

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper().readData('vehicleData').then((value) {
      setState(() {
        storedVehicleData = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _vehicleFormKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'License plate number',
                      // hintText: 'License plate number'
                    ),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    validator: (val) => val!.isEmpty
                        ? 'Please enter license plate number'
                        : null,
                    onChanged: (val) => setState(() {
                      vehiclePlateNumber = val;
                      // print('License plate number => $val');
                    }),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      // hintText: 'Chassis number',
                      labelText: 'Chassis number',
                    ),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    onChanged: (val) => setState(() {
                      vehicleChassisNumber = val;
                    }),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    hint: Text('Manufacturer'),
                    items: MyItemList().vehicleMakerList,
                    validator: (val) =>
                        val == null ? 'Please select vehicle manufacturer' : null,
                    onChanged: (val) =>
                        setState(() => vehicleMaker = val as String?),
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        // hintText: 'Model',
                        labelText: 'Model'),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter vehicle model' : null,
                    onChanged: (val) => setState(() {
                      vehicleModel = val;
                      // print('The income amount => $val');
                    }),
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      margin: EdgeInsets.only(right: 5.0),
                      child: TextFormField(
                        // enabled: true,
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: initialDateHandler(selectedDate),
                            ),
                        onTap: () => _selectDate(context),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      margin: EdgeInsets.only(left: 5.0),
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: DateTimeHelper().ageFromDate(selectedDate),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        // hintText: 'Enter price',
                        labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => setState(() {
                      vehiclePrice = val;
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
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic> vehicleInfo = {
                          'licensePlateNumber': vehiclePlateNumber, 
                          'chassisNumber': vehicleChassisNumber,
                          'manufacturer': vehicleMaker,
                          'model': vehicleModel,
                          'firstRegistrationDate': vehicleFirstRegistrationDate,
                          'purchasePrice': vehiclePrice
                        };
                        String mapToStr = jsonEncode(vehicleInfo);
                        /*SharedPreferencesHelper()
                            .saveData('vehicleData', mapToStr);
                        PageRouter()
                            .navigateToPage(InputVehiclePage(), context); */
                        if (_vehicleFormKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Saving vehicle information...')),
                          );
                           SharedPreferencesHelper()
                            .saveData('vehicleData', mapToStr);
                          PageRouter()
                              .navigateToPage(StoredVehiclePage(), context);
                        }
                      },
                      child: Text(
                        'SAVE',
                        style: TextStyle(color: Colors.white),
                      ),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.blue[900]),
                    ),
                  ),
                ],
              ),
              /* Container(
                width: MediaQuery.of(context).size.width * 0.90,
                margin: EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Text(storedVehicleData ?? ''),
                ),
              ) */
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
    return 'First registration date';
  } else {
    return toCmrDateFormat;
  }
}

storedDateHandler(DateTime mySelectedDate) {
  DateTime today = DateTime.now();
  DateFormat toDateFormat = DateFormat('yyyy-MM-dd');
  String todayFormatted = toDateFormat.format(today);
  String selectedDateFormatted = toDateFormat.format(mySelectedDate);
  if (selectedDateFormatted == todayFormatted) {
    return 'isEmpty';
  } else {
    return selectedDateFormatted;
  }
}

getStoredVehicleData() {
  SharedPreferencesHelper().readData('vehicleData').then((value) {
    Widget dataHolder = Text('$value');
    return dataHolder;
  });
}
