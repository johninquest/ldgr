import 'package:flutter/material.dart';
import 'package:tba/pages/records/all.dart';
// import 'package:tba/styles/colors.dart'; 
import 'package:tba/services/router.dart';
// import 'package:tba/pages/inputs/vehicle.dart';
import 'package:tba/pages/inputs/person.dart';
import 'package:tba/pages/about.dart';
import 'package:tba/pages/view/vehicle.dart';
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
            // leading: Icon(Icons.person, color: Colors.blue[900],),
            title: Text('Day', style: TextStyle(color: myBlue),),
            onTap: () => print('Pressed day button!'),
          ),
          ListTile(
              // leading: Icon(Icons.directions_car, color: Colors.blue[900],),
              title: Text('Week', style: TextStyle(color: myBlue),),
              onTap: () => print('Pressed week button!')
              // onTap: () => PageRouter().navigateToPage(StoredVehiclePage(), context)
              ),   
          ListTile(
            // leading: Icon(Icons.info, color: Colors.blue[900],),
            title: Text('Month', style: TextStyle(color: myBlue),),
            onTap: () => print('Pressed month button!'),
            // onTap: () => PageRouter().navigateToPage(AboutPage(), context),
          ),
          ListTile(
            // leading: Icon(Icons.info, color: Colors.blue[900],),
            title: Text('Year', style: TextStyle(color: myBlue),),
            onTap: () => print('Pressed year button!'),
            // onTap: () => PageRouter().navigateToPage(AboutPage(), context),
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
          /* Container(
            width: 40.0,
              child: ElevatedButton(
                onPressed: () => print('Show button pressed!'), 
                child: Text('Show'), 
                style: ElevatedButton.styleFrom(primary: myBlue),),), */
        ],
      ),
    ),);
  }
}