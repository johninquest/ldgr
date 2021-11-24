import 'package:flutter/material.dart'; 

class InputCategoryPage extends StatelessWidget {
  const InputCategoryPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter category'),
        centerTitle: true,
      ),
      body: Center(child: Text('Hello world!'),),
      
    );
  }
}