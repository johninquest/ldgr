import 'package:flutter/material.dart';

class InputPersonPage extends StatelessWidget {
  const InputPersonPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter person'),
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

  String? personName;
  @override
  Widget build(BuildContext context) {
    return Container(child: Form(
      key: _personFormKey,
      child: Column(children: [
                    Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: TextFormField(
                    decoration:
                        InputDecoration(hintText: 'Name'),
                    keyboardType: TextInputType.text, 
                    textCapitalization: TextCapitalization.words,
                    validator: (val) => val!.isEmpty
                        ? 'Please enter license plate number!'
                        : null,
                    onChanged: (val) => setState(() {
                      personName = val;
                      // print('License plate number => $val');
                    }),
                  )),
    ],)),
      
    );
  }
}