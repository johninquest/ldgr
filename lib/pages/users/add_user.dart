import 'package:flutter/material.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add user'), 
        centerTitle: true,
      ),
      body: Container(child: Center(child: Text('Add new user'),),),
      
    );
  }
}