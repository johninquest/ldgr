import 'package:flutter/material.dart';
import 'package:tba/shared/lists.dart';

class InputPersonPage extends StatelessWidget {
  const InputPersonPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter personal info'),
        centerTitle: true,
      ),
      body: Container(child: Center(child: PersonForm(),),),
      
    );
  }
}

class PersonForm extends StatefulWidget {
  const PersonForm({ Key? key }) : super(key: key);

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
  String? email; 
  String? role;

  @override
  Widget build(BuildContext context) {
    return Container(child: Form(
      key: _personFormKey,
      child: SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
                    Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    enabled: true,
                    decoration:
                        InputDecoration(
                          // hintText: 'Surname', 
                          labelText: 'Last name / Surname'),
                    keyboardType: TextInputType.text, 
                    textCapitalization: TextCapitalization.words,
                    validator: (val) => val!.isEmpty
                        ? 'Please enter surname'
                        : null,
                    onChanged: (val) => setState(() {
                      surname = val;
                      // print('License plate number => $val');
                    }),
                  )), 
                  Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    enabled: true,
                    decoration:
                        InputDecoration(labelText: 'First name / Given names'),
                    keyboardType: TextInputType.text, 
                    textCapitalization: TextCapitalization.words,
                    validator: (val) => val!.isEmpty
                        ? 'Please enter given names'
                        : null,
                    onChanged: (val) => setState(() {
                      givenNames = val;
                      // print('License plate number => $val');
                    }),
                  )), 
                  Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    enabled: true,
                    decoration:
                        InputDecoration(labelText: 'Address'),
                    keyboardType: TextInputType.text, 
                    textCapitalization: TextCapitalization.words,
                    /* validator: (val) => val!.isEmpty
                        ? 'Please enter your address!'
                        : null, */
                    onChanged: (val) => setState(() {
                      address = val;
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
                      width: MediaQuery.of(context).size.width * 0.35,
                      margin: EdgeInsets.only(right: 5.0),
                      child: TextFormField(
                        // enabled: true,
                        readOnly: true,
                        decoration: InputDecoration(
                            hintText: 'City/Town',
                            ),
                        keyboardType: TextInputType.text, 
                    textCapitalization: TextCapitalization.words,
                    validator: (val) => val!.isEmpty
                        ? 'Please enter given names'
                        : null,
                    onChanged: (val) => setState(() {
                      city = val;
                      // print('License plate number => $val');
                    }),    
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      margin: EdgeInsets.only(left: 5.0),
                      child: DropdownButtonFormField(
                    isExpanded: true,
                    hint: Text('Country'),
                    items: MyItemList().countryList,
                    validator: (val) =>
                        val == null ? 'Please enter country' : null,
                    onChanged: (val) =>
                        setState(() => country = val as String?),
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
                    enabled: true,
                    decoration:
                        InputDecoration(hintText: 'Phone number'),
                    keyboardType: TextInputType.text, 
                    textCapitalization: TextCapitalization.words,
                    /* validator: (val) => val!.isEmpty
                        ? 'Please enter your phone number!'
                        : null, */
                    onChanged: (val) => setState(() {
                      phoneNumber = val;
                      // print('License plate number => $val');
                    }),
                  )), 
                  Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    enabled: true,
                    decoration:
                        InputDecoration(labelText: 'E-Mail'),
                    keyboardType: TextInputType.text, 
                    textCapitalization: TextCapitalization.words,
                    /* validator: (val) => val!.isEmpty
                        ? 'Please enter your phone number!'
                        : null, */
                    onChanged: (val) => setState(() {
                      email = val;
                      // print('License plate number => $val');
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
                    onChanged: (val) =>
                        setState(() => role = val as String?),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Still under construction!')),
                          );
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
    ],)),),
      
    );
  }
}