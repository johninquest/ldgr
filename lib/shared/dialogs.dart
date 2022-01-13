import 'package:flutter/material.dart';
import 'package:ldgr/styles/colors.dart';

class InfoDialog extends StatelessWidget {
  // const InfoDialog({ Key? key }) : super(key: key); 
  final String infoMessage;
  InfoDialog(this.infoMessage);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(Icons.info_outline, color: myBlue, size: 40.0,), 
      content: Text(infoMessage, textAlign: TextAlign.center,), 
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
                borderRadius: BorderRadius.all(Radius.circular(10.0))),  
    );
  }
}

class ErrorDialog extends StatelessWidget {
  // const ErrorDialog({ Key? key }) : super(key: key); 
  final String errorMessage;
  ErrorDialog(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(Icons.report_outlined, color: myRed, size: 40.0,), 
      content: Text(errorMessage, textAlign: TextAlign.center,), 
      actions:[
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('OK', style: TextStyle(fontSize: 20, color: myRed),),
            ],
          ))
      ],
      shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),  
    );
  }
}