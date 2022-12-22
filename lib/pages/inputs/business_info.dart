import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:ldgr/utils/preprocessor.dart';
import 'package:ldgr/utils/printing.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/db/sp_helper.dart';
import 'package:ldgr/shared/snackbar_messages.dart';
import 'package:ldgr/styles/colors.dart';

class InputPersonPage extends StatelessWidget {
  const InputPersonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('business info'),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: PersonForm(),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
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
  TextEditingController _businessName = TextEditingController();
  // TextEditingController _givenNames = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper().readData('currentUserData').then((value) {
      if (value != null) {
        setState(() {
          _businessName.text =
              DataParser().strToMap(value)['businessName'] ?? '';
          _city.text = DataParser().strToMap(value)['businessLocation'] ?? '';
        });
      }
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
                  controller: _businessName,
                  enabled: true,
                  decoration: InputDecoration(labelText: 'Business name'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter business name' : null,
                  /* onChanged: (val) => setState(() {
                    surname = val;
                  }), */
                )),
            /*  Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
                  controller: _givenNames,
                  enabled: true,
                  decoration:
                      InputDecoration(labelText: 'First name / Given names'),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  /* validator: (val) => val!.isEmpty
                        ? 'Please enter given names'
                        : null, */
                )), */
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
                )),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              margin: EdgeInsets.only(bottom: 5.0),
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: TextFormField(
                controller: _city,
                enabled: true,
                decoration: InputDecoration(
                  labelText: 'City / Town',
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.95,
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
                  controller: _phone,
                  enabled: true,
                  decoration: InputDecoration(labelText: 'Phone number'),
                  keyboardType: TextInputType.phone,
                  textCapitalization: TextCapitalization.words,
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
                )),
/*             Container(
                width: MediaQuery.of(context).size.width * 0.95,
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: DropdownButtonFormField(
                  value: _role,
                  isExpanded: true,
                  items: MyItemList().personRoleList,
                  /* validator: (val) =>
                      val == null ? 'Please select role' : null, */
                  onChanged: (val) => setState(() => _role = val as String?),
                  decoration: InputDecoration(labelText: 'Role'),
                )), */
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
                      style: TextStyle(letterSpacing: 1.0, color: blackColor),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Map<String, dynamic> personInfo = {
                        'businessName': _businessName.text,
                        // 'given_names': _givenNames.text,
                        'address': _address.text,
                        'city': _city.text,
                        'phone': _phone.text,
                        'email': _email.text,
                        // 'role': _role,
                      };
                      String personMapToStr = jsonEncode(personInfo);
                      if (_personFormKey.currentState!.validate()) {
                        SharedPreferencesHelper()
                            .storeData('personData', personMapToStr);
                        SnackBarMessage().saveSuccess(context);
                      }
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(letterSpacing: 1.0),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic> personInfo = {
                          'businessName': _businessName.text,
                          // 'given_names': _givenNames.text,
                          'address': _address.text,
                          'city': _city.text,
                          'phone': _phone.text,
                          'email': _email.text,
                          // 'role': _role,
                        };
                        String personMapToStr = jsonEncode(personInfo);
                        if (_personFormKey.currentState!.validate()) {
                          SharedPreferencesHelper()
                              .storeData('personData', personMapToStr)
                              .then((value) {
                            SnackBarMessage().saveSuccess(context);
                            CustomDelay().bySeconds(3);
                            PrintService().personPdf(context);
                          });
                        }
                      },
                      child: Text(
                        'PRINT',
                        style: TextStyle(letterSpacing: 1.0, color: blackColor),
                      ),
                    ))
              ],
            ),
          ],
        )),
      ),
    );
  }
}
