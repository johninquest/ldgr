import 'package:flutter/material.dart';
import 'package:rba/pages/inputs/category.dart';
import 'package:rba/pages/inputs/country.dart';
import 'package:rba/services/router.dart';
import 'package:rba/pages/inputs/person.dart';
import 'package:rba/pages/about.dart';
// import 'package:rba/pages/records/vehicle.dart';
import 'package:rba/styles/colors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

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
                child: Text('Settings',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
            ListTile(
              leading: Icon(
                Icons.business,
                color: myBlue,
              ),
              title: Text(
                'Business',
                style: TextStyle(color: Colors.blue[900]),
              ),
              onTap: () =>
                  PageRouter().navigateToPage(InputPersonPage(), context),
            ),
            ListTile(
              leading: Icon(
                Icons.category,
                color: myBlue,
              ),
              title: Text(
                'Categories',
                style: TextStyle(color: Colors.blue[900]),
              ),
              onTap: () => PageRouter().navigateToPage(InputCategoryPage(), context),
            ),
            /* ListTile(
              leading: Icon(
                Icons.person,
                color: myBlue,
              ),
              title: Text(
                'Person info',
                style: TextStyle(color: Colors.blue[900]),
              ),
              onTap: () =>
                  PageRouter().navigateToPage(InputPersonPage(), context),
            ),
            ListTile(
                leading: Icon(
                  Icons.directions_car,
                  color: myBlue,
                ),
                title: Text(
                  'Vehicle info',
                  style: TextStyle(color: Colors.blue[900]),
                ),
                onTap: () =>
                    PageRouter().navigateToPage(StoredVehiclePage(), context)),  */
            ListTile(
                leading: Icon(
                  Icons.language,
                  color: myBlue,
                ),
                title: Text(
                  'Country',
                  style: TextStyle(color: Colors.blue[900]),
                ),
                onTap: () =>
                    PageRouter().navigateToPage(CountryPage(), context)),        
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.blue[900],
              ),
              title: Text(
                'About app',
                style: TextStyle(color: Colors.blue[900]),
              ),
              onTap: () => PageRouter().navigateToPage(AboutPage(), context),
            ),
          ],
        ),
      ),
    );
  }
}

