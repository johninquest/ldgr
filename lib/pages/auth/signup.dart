import 'package:flutter/material.dart'; 

class SignUpPage extends StatelessWidget {
  const SignUpPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
      ),
      body: SignUpOptions(),
    );
  }
}

class SignUpOptions extends StatefulWidget {
  const SignUpOptions({ Key? key }) : super(key: key);

  @override
  _SignUpOptionsState createState() => _SignUpOptionsState();
}

class _SignUpOptionsState extends State<SignUpOptions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(child: Icon(Icons.email,),),
          ElevatedButton(onPressed: () => print('Tapped e-mail button'), child: Text('Sign up with E-mail'))
        ],
      ),
      
    );
  }
}