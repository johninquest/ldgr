import 'package:flutter/material.dart';
import 'package:ldgr/firebase/auth.dart';
import 'package:ldgr/pages/inputs/country.dart';
import 'package:ldgr/pages/inputs/login.dart';
import 'package:ldgr/pages/records/items.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/pages/inputs/business.dart';
import 'package:ldgr/pages/about.dart';
import 'package:ldgr/shared/dialogs.dart';
import 'package:ldgr/styles/colors.dart';

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
                decoration: BoxDecoration(color: myBlue),
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
                style: TextStyle(color: myBlue),
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
                'Items',
                style: TextStyle(color: myBlue),
              ),
              onTap: () => PageRouter().navigateToPage(ItemsPage(), context),
              /* onTap: () => showDialog(
                  context: context, 
                  builder: (_) => InfoDialog('Still under construction!'), 
                  barrierDismissible: false), */
            ),
            ListTile(
              leading: Icon(
                Icons.inventory_outlined,
                color: myBlue,
              ),
              title: Text(
                'Inventory',
                style: TextStyle(color: myBlue),
              ),
              onTap: () => showDialog(
                  context: context,
                  builder: (_) => InfoDialog('Still under construction!'),
                  barrierDismissible: false),
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
                  style: TextStyle(color: myBlue),
                ),
                onTap: () =>
                    PageRouter().navigateToPage(CountryPage(), context)),
            ListTile(
              leading: Icon(
                Icons.info_outline,
                color: myBlue,
              ),
              title: Text(
                'About app',
                style: TextStyle(color: myBlue),
              ),
              onTap: () => PageRouter().navigateToPage(AboutPage(), context),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: myBlue,
              ),
              title: Text(
                'Log out',
                style: TextStyle(color: myBlue),
              ),
              onTap: () {
                FirebaseAuthService().logoutUser();
                PageRouter().navigateToPage(LoginPage(), context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
