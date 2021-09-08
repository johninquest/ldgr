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
      body: Container(child: Center(child: Text('Enter personal information!'),),),
      
    );
  }
}