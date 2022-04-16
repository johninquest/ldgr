import 'package:flutter/material.dart';

import '../../db/sp_helper.dart';
import '../../services/date_time_helper.dart';
import '../../services/preprocessor.dart';
import '../../styles/colors.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add user'),
          centerTitle: true,
        ),
        body: Center(
          child: UserForm(),
        ));
  }
}

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _userFormKey = GlobalKey<FormState>();
  TextEditingController _userName = TextEditingController();
  String? _currentUser;

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper().readData('currentUserData').then((value) {
      if (value != null) {
        setState(() {
          _currentUser = DataParser().strToMap(value)['name'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _userFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(),
          Container(
              width: MediaQuery.of(context).size.width * 0.90,
              margin: EdgeInsets.only(bottom: 10.0),
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextFormField(
                controller: _userName,
                decoration: InputDecoration(labelText: 'Name'),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter name';
                  }
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('CANCEL'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    String _timestampsString =
                        DateTimeHelper().timestampForDB(DateTime.now());
                    if (_userFormKey.currentState!.validate()) {
                      String _userId =
                          AuthIdGenerator().fromName(_userName.text);
                      Map<String, dynamic> _userData = {
                        'name': _userName.text.trim(),
                        'role': 'employee',
                        'user_id': _userId,
                        'created_at': _timestampsString,
                        'last_update_at': '',
                        'entered_by': _currentUser ?? '',
                      };
                      print(_userData);
                    } /* else {
                      print('Form is invalid!');
                    } */
                  },
                  child: Text('SAVE'),
                  style: ElevatedButton.styleFrom(primary: myRed),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
