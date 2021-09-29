import 'package:flutter/material.dart';
import 'package:tba/shared/lists.dart';
import 'dart:convert';
import 'package:tba/data/sp_helper.dart';

class InputPersonPage extends StatelessWidget {
  const InputPersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter personal info'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: PersonForm(),
        ),
      ),
    );
  }
}

class PersonForm extends StatefulWidget {
  const PersonForm({Key? key}) : super(key: key);

  @override
  _PersonFormState createState() => _PersonFormState();
}

class _PersonFormState extends State<PersonForm> {
  final _personFormKey = GlobalKey<FormState>();
  TextEditingController _surname = TextEditingController();
  TextEditingController _givenNames = TextEditingController(); 
  TextEditingController _address = TextEditingController(); 
  TextEditingController _city = TextEditingController(); 
  TextEditingController _country = TextEditingController();
  TextEditingController _phone = TextEditingController(); 
  TextEditingController _email = TextEditingController(); 
  TextEditingController _role = TextEditingController();

  String? surname;
  String? givenNames;
  String? address;
  String? city;
  String? country;
  String? phone;
  String? eMail;
  String? role;

   String? storedPersonData;

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper().readData('personData').then((value) {
      setState(() {
        storedPersonData = value;
        _surname.text = getStoredPerson(value)['surname'];
        _givenNames.text = getStoredPerson(value)['given_names']; 
        _address.text = getStoredPerson(value)['address'];
        _city.text = getStoredPerson(value)['city']; 
        _country.text = getStoredPerson(value)['country']; 
        _phone.text = getStoredPerson(value)['phone'];
        _email.text = getStoredPerson(value)['email']; 
        _role.text = getStoredPerson(value)['role'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _personFormKey,
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
                  controller: _surname,
                  enabled: true,
                  decoration: InputDecoration(
                      // hintText: 'Surname',
                      labelText: 'Last name/Surname'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter last name / surname' : null,
                  onChanged: (val) => setState(() {
                    surname = val;
                  }),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
                  controller: _givenNames,
                  enabled: true,
                  decoration:
                      InputDecoration(labelText: 'First name/Given names'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  /* validator: (val) => val!.isEmpty
                        ? 'Please enter given names'
                        : null, */
                  onChanged: (val) => setState(() {
                    givenNames = val;
                  }),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
                  controller: _address,
                  enabled: true,
                  decoration: InputDecoration(labelText: 'Address'),
                  keyboardType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (val) => setState(() {
                    address = val;
                  }),
                )),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              margin: EdgeInsets.only(bottom: 5.0),
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: TextFormField(
                controller: _city,
                enabled: true,
                decoration: InputDecoration(
                  hintText: 'City/Town',
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                onChanged: (val) => setState(() {
                  city = val;
                }),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              margin: EdgeInsets.only(bottom: 5.0),
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: DropdownButtonFormField(
                // value: '',
                isExpanded: true,
                hint: Text('Country'),
                items: MyItemList().countryList,
                validator: (val) =>
                    val == null ? 'Please select country' : null,
                onChanged: (val) => setState(() => country = val as String?),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
                  controller: _phone,
                  enabled: true,
                  decoration: InputDecoration(hintText: 'Phone number'),
                  keyboardType: TextInputType.phone,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (val) => setState(() {
                    phone = val;
                  }),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
                  controller: _email,
                  enabled: true,
                  decoration: InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val) => setState(() {
                    eMail = val;
                  }),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: DropdownButtonFormField(
                  // value: '',
                  isExpanded: true,
                  hint: Text('Role'),
                  items: MyItemList().personRoleList,
                  validator: (val) =>
                      val == null ? 'Please enter your role' : null,
                  onChanged: (val) => setState(() => role = val as String?),
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
                      Map<String, dynamic> personInfo = {
                        'surname': _surname.text,
                        'given_names': _givenNames.text,
                        'address': _address.text,
                        'city': _city.text,
                        'country': country ?? '',
                        'phone': _phone.text,
                        'email': _email.text,
                        'role': role ?? '',
                      };
                      String personMapToStr = jsonEncode(personInfo);
                      if (_personFormKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Still under construction!')),
                        );
                        print(personInfo);
                        print(personMapToStr.runtimeType);
                      }
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}

getStoredPerson(String? personStr) {
  if (personStr != null) {
    Map strToMap = jsonDecode(personStr);
    return strToMap;
  } else {
    return null;
  }
}
