import 'package:flutter/material.dart';

class InputVehiclePage extends StatelessWidget {
  const InputVehiclePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter vehicle'),
        centerTitle: true,
      ),
      body: Container(child: Center(child: Text('Enter vehicle information!'),),),
      
    );
  }
}