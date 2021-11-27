import 'package:flutter/material.dart';
import 'package:ldgr/styles/colors.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(Icons.info_outline, color: myBlue, size: 40.0,), 
      content: Text('Still under construction!', textAlign: TextAlign.center,), 
      actions:[
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('OK', style: TextStyle(fontSize: 20,),),
            ],
          ))
      ],
      shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),  
    );
  }
}