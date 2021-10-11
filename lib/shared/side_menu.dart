import 'package:flutter/material.dart';
// import 'package:tba/styles/colors.dart'; 
import 'package:tba/services/router.dart';
// import 'package:tba/pages/inputs/vehicle.dart';
import 'package:tba/pages/inputs/person.dart';
import 'package:tba/pages/about.dart';
import 'package:tba/pages/records/vehicle.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({ Key? key }) : super(key: key);

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
              child: Text('Menu',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
          ListTile(
            leading: Icon(Icons.person, color: Colors.blue[900],),
            title: Text('Personal info', style: TextStyle(color: Colors.blue[900]),),
            onTap: () => PageRouter().navigateToPage(InputPersonPage(), context),
          ),
          ListTile(
              leading: Icon(Icons.directions_car, color: Colors.blue[900],),
              title: Text('Vehicle info', style: TextStyle(color: Colors.blue[900]),),
              onTap: () => PageRouter().navigateToPage(StoredVehiclePage(), context)
              ),   
          ListTile(
            leading: Icon(Icons.info, color: Colors.blue[900],),
            title: Text('About', style: TextStyle(color: Colors.blue[900]),),
            // onTap: () => print('Pressed about button!'),
            onTap: () => PageRouter().navigateToPage(AboutPage(), context),
          ),
         
        ],
      ),
    ),);
  }
}