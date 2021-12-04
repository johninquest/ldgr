import 'package:flutter/material.dart';
import 'package:ldgr/firebase/auth.dart';
import 'package:ldgr/pages/home.dart';
import 'package:ldgr/services/auth.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/shared/dialogs.dart';
import 'package:ldgr/styles/colors.dart';

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
      // bottomNavigationBar: BottomNavBar(),
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
            Container(
              child: Text(
                'The bookkeeping app for bars and restaurants',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: myBlue, fontSize: 16.0),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.75,
                margin: EdgeInsets.only(bottom: 10.0, top: 40.0),
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _userName,
                  decoration: InputDecoration(labelText: 'Username'),
                  keyboardType: TextInputType.text,
                  // textCapitalization: TextCapitalization.words,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter username!';
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
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter password!';
                    }
                  },
                )),
            Container(
              width: MediaQuery.of(context).size.width * 0.50,
              margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_loginFormKey.currentState!.validate()) {
                    var adminAuth = AdminAuthService()
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
                    }
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
