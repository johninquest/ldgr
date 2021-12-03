import 'package:flutter/material.dart'; 
 
class ItemDetailPage extends StatelessWidget {
  final rowData;
  const ItemDetailPage({ Key? key, required this.rowData }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('$rowData'),
    );
  }
}