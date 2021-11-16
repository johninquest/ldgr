import 'package:flutter/material.dart';
import 'package:tba/pages/records/all.dart';
import 'package:tba/services/router.dart';
import 'package:tba/styles/colors.dart';

class FilterMenu extends StatelessWidget {
  const FilterMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[900]),
              child: Text('Filter Options',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
          ListTile(
            title: Text('Day', style: TextStyle(color: myBlue),),
            onTap: () => print('Pressed day button!'),
          ),
          ListTile(
              title: Text('Week', style: TextStyle(color: myBlue),),
              onTap: () => print('Pressed week button!')
              ),   
          ListTile(
            title: Text('Month', style: TextStyle(color: myBlue),),
            onTap: () => print('Pressed month button!'),
          ),
          ListTile(
            title: Text('Year', style: TextStyle(color: myBlue),),
            onTap: () => print('Pressed year button!'),
          ),
          ListTile(
            // leading: Icon(Icons.info, color: Colors.blue[900],),
            title: Text('All', style: TextStyle(color: myBlue),),
            // onTap: () => print('Pressed all button!'),
            onTap: () => PageRouter().navigateToPage(AllRecords(), context),
          ),
          ListTile(
            leading: Container(child: Text(''),),
            title: Container(child: ElevatedButton(
                onPressed: () => print('Show button pressed!'), 
                child: Text('Show'), 
                style: ElevatedButton.styleFrom(primary: myBlue),),),    
            trailing: Container(child: Text(''),),    
          ),
        ],
      ),
    ),);
  }
}