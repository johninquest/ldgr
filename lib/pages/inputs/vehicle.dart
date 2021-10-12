import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tba/services/router.dart';
import 'dart:convert';
import 'package:tba/shared/lists.dart';
import 'package:tba/services/date_time_helper.dart';
import 'package:tba/data/sp_helper.dart';
import 'package:tba/pages/records/vehicle.dart';
import 'package:tba/shared/snackbar_messages.dart';

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
  final _vehicleFormKey = GlobalKey<FormState>();
  TextEditingController _plateNumber = TextEditingController();
  TextEditingController _chassisNumber = TextEditingController();
  TextEditingController _model = TextEditingController();
  TextEditingController _firstRegistrationDate = TextEditingController();
  TextEditingController _age = TextEditingController();
  TextEditingController _price = TextEditingController();

  String? vehicleMaker;

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
        _firstRegistrationDate.text = formatDisplayedDate('$picked');
        _age.text = DateTimeHelper().ageFromDate(picked);
      });
  }

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper().readData('vehicleData').then((value) {
      setState(() {
        if (value != null) {
          _plateNumber.text =
              getStoredVehicle(value)['licensePlateNumber'] ?? '';
          _chassisNumber.text = getStoredVehicle(value)['chassisNumber'] ?? '';
          _model.text = getStoredVehicle(value)['model'] ?? '';
          vehicleMaker = getStoredVehicle(value)['maker'] ?? '';
          _firstRegistrationDate.text =
              getStoredVehicle(value)['firstRegistrationDate'] ?? '';
          _age.text = getStoredVehicle(value)['age'] ?? '';
          _price.text = getStoredVehicle(value)['purchasePrice'] ?? '';
        }
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
                  margin: EdgeInsets.only(bottom: 5.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    controller: _plateNumber,
                    decoration: InputDecoration(
                      labelText: 'License plate number',
                    ),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    validator: (val) => val!.isEmpty
                        ? 'Please enter license plate number'
                        : null,
/*                     onChanged: (val) => setState(() {
                      vehiclePlateNumber = val;
                    }), */
                  )),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 5.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    controller: _chassisNumber,
                    decoration: InputDecoration(
                      // hintText: 'Chassis number',
                      labelText: 'Chassis number',
                    ),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    /*  onChanged: (val) => setState(() {
                      vehicleChassisNumber = val;
                    }), */
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: DropdownButtonFormField(
                  value: vehicleMaker,
                  isExpanded: true,
                  // hint: Text('Manufacturer'),
                  items: MyItemList().vehicleMakerList,
                  validator: (val) =>
                      val == null ? 'Please select vehicle manufacturer' : null,
                  onChanged: (val) =>
                      setState(() => vehicleMaker = val as String?),
                  decoration: InputDecoration(labelText: 'Manufacturer'),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 5.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    controller: _model,
                    decoration: InputDecoration(labelText: 'Model'),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter vehicle model' : null,
                    /* onChanged: (val) => setState(() {
                      vehicleModel = val;
                    }), */
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      margin: EdgeInsets.only(right: 5.0),
                      child: TextFormField(
                        controller: _firstRegistrationDate,
                        enabled: true,
                        readOnly: true,
                        decoration: InputDecoration(
                          // hintText: initialDateHandler(selectedDate),
                          labelText: 'First registration date',
                        ),
                        onTap: () => _selectDate(context),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.24,
                      margin: EdgeInsets.only(left: 5.0),
                      child: TextFormField(
                        controller: _age,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          /* hintText: vehicleAge ?? '',
                          hintText: DateTimeHelper().ageFromDate(selectedDate), */
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    controller: _price,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    /* onChanged: (val) => setState(() {
                      vehiclePrice = val;
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
                          'licensePlateNumber': _plateNumber.text,
                          'chassisNumber': _chassisNumber.text,
                          'maker': vehicleMaker ?? '',
                          'model': _model.text,
                          'firstRegistrationDate': _firstRegistrationDate.text,
                          'age': _age.text,
                          'purchasePrice': _price.text,
                        };
                        String vehicleMapToStr = jsonEncode(vehicleInfo);
                        if (_vehicleFormKey.currentState!.validate()) {
                          SharedPreferencesHelper()
                              .saveData('vehicleData', vehicleMapToStr);
                          SnackBarMessage().saveSuccess(context);
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
            ],
          ),
        ),
      ),
    );
  }
}

formatDisplayedDate(String dt) {
  if (DateTime.tryParse(dt) != null && dt != '') {
    DateTime parsedDatTime = DateTime.parse(dt);
    DateFormat cmrDateFormat = DateFormat('dd/MM/yyyy');
    String toCmrDateFormat = cmrDateFormat.format(parsedDatTime);
    return toCmrDateFormat;
  } else {
    return '--/--/----';
  }
}

getStoredVehicle(String? vehicleStr) {
  if (vehicleStr != null) {
    Map strToMap = jsonDecode(vehicleStr);
    return strToMap;
  } else {
    return {};
  }
}
