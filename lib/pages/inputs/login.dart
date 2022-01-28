import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ldgr/db/sp_helper.dart';
// import 'package:ldgr/firebase/auth.dart';
import 'package:ldgr/firebase/firestore.dart';
import 'package:ldgr/pages/home.dart';
import 'package:ldgr/services/auth.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/shared/dialogs.dart';
import 'package:ldgr/styles/colors.dart';
import 'dart:convert';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ldgr',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 3.0,
              color: Colors.white,
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _userName = TextEditingController();
  TextEditingController _userPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* Container(
              child: Text(
                'The bookkeeping app for bars and restaurants',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: myBlue, fontSize: 16.0),
              ),
            ), */
            Container(
                width: MediaQuery.of(context).size.width * 0.75,
                margin: EdgeInsets.only(bottom: 10.0, top: 40.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _userName,
                  decoration: InputDecoration(labelText: 'UserId'),
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter UserId!';
                    }
                  },
                )),
            Container(
                width: MediaQuery.of(context).size.width * 0.75,
                margin: EdgeInsets.only(bottom: 20.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _userPassword,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(labelText: 'Password'),
                  keyboardType: TextInputType.text,
/*                   validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter password!';
                    }
                  }, */
                )),
            Container(
              width: MediaQuery.of(context).size.width * 0.50,
              margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  String userNameCleanedUp =
                      _userName.text.trim().toLowerCase();
                  String userPasswordCleanedUp =
                      _userPassword.text.trim().toLowerCase();
                  if (_loginFormKey.currentState!.validate()) {
                    var adminAuth = AuthService()
                        .verifyAdmin(userNameCleanedUp, userPasswordCleanedUp);
                    if (adminAuth == 'auth_success') {
                      PageRouter().navigateToPage(HomePage(), context);
                    } else {
                      FirestoreService()
                          .checkIfDocExists(userNameCleanedUp)
                          .then((DocumentSnapshot snapshot) {
                        if (snapshot.exists) {
                          Map<String, dynamic> _data = snapshot.data() as Map<String, dynamic>;
                          String name = _data['name'] ?? '';
                          String role = _data['role'] ?? '';
                          String businessName = _data['business_name'] ?? '';
                          String businessLocation = _data['location'] ?? '';
                          storeCurrentUser(
                              name, role, businessName, businessLocation);
                          PageRouter().navigateToPage(HomePage(), context);
                        } else {
                          
                          showDialog(
                              context: context,
                              builder: (_) => ErrorDialog('Access denied!'));
                        }
                      }).catchError((e) {
                        
                        showDialog(
                            context: context,
                            builder: (_) => ErrorDialog(
                                'Something went wrong.\n Please inform your manager!'));
                      });
                    }

                    /* var adminAuth = AdminAuthService()
                        .verifyAdmin(_userName.text, _userPassword.text);
                    if (adminAuth == 'auth_success') {
                      PageRouter().navigateToPage(HomePage(), context);
                    } else {
                      var _authUser = FirebaseAuthService().loginUser(
                          _userName.text.trim(), _userPassword.text.trim());
                      _authUser.then((val) {
                        if (val == null) {
                          showDialog(
                              context: context,
                              builder: (_) => ErrorDialog('Access denied!'));
                        } else {
                          PageRouter().navigateToPage(HomePage(), context);
                        }
                      });
                    } */
                  }
                },
                child: Text(
                  'Log in',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: myBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

storeCurrentUser(
    String userName, String userRole, String bName, String bLocation) {
  Map _toMap = {
    'name': userName,
    'role': userRole,
    'businessName': bName,
    'businessLocation': bLocation
  };
  String _currentUserData = jsonEncode(_toMap);
  SharedPreferencesHelper().storeData('currentUserData', _currentUserData);
}
