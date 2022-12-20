import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../db/sp_helper.dart';
import '../firebase/firestore.dart';
import '../services/auth.dart';
import '../services/router.dart';
import '../shared/dialogs.dart';
import '../styles/colors.dart';
import 'home.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ldgr',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
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
  bool? isChecked = false;

  @override
  void initState() {
    super.initState();
    final _spHelper = SharedPreferencesHelper();
    _spHelper.readData('loginId').then((value) {
      if (value != null) {
        _authenticateUser(value, '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        return 'Please enter UserId';
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
                    enabled: true,
                    /*                   validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter password';
                      }
                    }, */
                  )),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                margin: EdgeInsets.only(bottom: 20.0),
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      // fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value as bool;
                        });
                      },
                    ),
                    Text('Remember me'),
                  ],
                ),
              ),
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
                      _authenticateUser(
                          userNameCleanedUp, userPasswordCleanedUp);
                    }
                  },
                  child: Text(
                    'Log in',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        wordSpacing: 3.0,
                        letterSpacing: 0.3),
                  ),
                  /* style: ElevatedButton.styleFrom(
                    backgroundColor: myBlue,
                  ), */
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _authenticateUser(String authName, authPassword) {
    var adminAuth = AuthService().verifyAdmin(authName, authPassword);
    if (adminAuth == 'auth_success') {
      String name = 'admin';
      String role = 'admin';
      String businessName = '';
      String businessLocation = '';
      storeCurrentUser(name, role, businessName, businessLocation);
      PageRouter().navigateToPage(HomePage(), context);
    } else {
      FirestoreService()
          .checkIfDocExists(authName)
          .then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          Map<String, dynamic> _data = snapshot.data() as Map<String, dynamic>;
          String name = _data['name'] ?? '';
          String role = _data['role'] ?? '';
          String businessName = _data['business_name'] ?? '';
          String businessLocation = _data['city'] ?? '';
          storeCurrentUser(name, role, businessName, businessLocation);
          storeRememberMeUser(isChecked as bool, authName);
          PageRouter().navigateToPage(HomePage(), context);
        } else {
          showDialog(
              context: context, builder: (_) => ErrorDialog('Access denied!'));
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

storeRememberMeUser(bool rmState, String? userId) {
  if (rmState == true) {
    final _spHelper = SharedPreferencesHelper();
    _spHelper.storeData('loginId', userId ?? '');
  }
}
