import 'package:flutter/material.dart';
import 'package:tba/shared/lists.dart';
import 'dart:convert';

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

  String? surname;
  String? givenNames;
  String? address;
  String? city;
  String? country;
  String? phoneNumber;
  String? eMail;
  String? role;

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
                  enabled: true,
                  decoration: InputDecoration(hintText: 'Phone number'),
                  keyboardType: TextInputType.phone,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (val) => setState(() {
                    phoneNumber = val;
                  }),
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
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
                        'surname': surname ?? '',
                        'given_names': givenNames ?? '',
                        'address': address ?? '',
                        'city': city ?? '',
                        'country': country ?? '',
                        'phone': phoneNumber ?? '',
                        'email': eMail ?? '',
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
