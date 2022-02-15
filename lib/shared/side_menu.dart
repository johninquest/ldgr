import 'package:flutter/material.dart';
import 'package:ldgr/db/sp_helper.dart';
import 'package:ldgr/pages/inputs/country.dart';
import 'package:ldgr/pages/analysis/overview.dart';
import 'package:ldgr/services/preprocessor.dart';
import 'package:ldgr/services/router.dart';
import 'package:ldgr/pages/inputs/business_info.dart';
import 'package:ldgr/pages/about.dart';
import 'package:ldgr/styles/colors.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String? _currentUser;
  @override
  Widget build(BuildContext context) {
    SharedPreferencesHelper().readData('currentUserData').then((val) {
      if (val != null) {
        setState(() {
          _currentUser = DataParser().strToMap(val)['name'];
        });
      }
    });
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(color: myBlue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50.0,
                    ),
                    Text(
                      _currentUser ?? '',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )
                  ],
                )),
            ListTile(
              leading: Icon(
                Icons.bar_chart,
                color: myBlue,
              ),
              title: Text(
                'Analysis',
                style: TextStyle(color: myBlue),
              ),
              onTap: () => PageRouter().navigateToPage(AnalysisPage(), context),
            ),
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
            /* ListTile(
              leading: Icon(
                Icons.category,
                color: myBlue,
              ),
              title: Text(
                'Items',
                style: TextStyle(color: myBlue),
              ),
              // onTap: () => PageRouter().navigateToPage(ItemsPage(), context),
              onTap: () => showDialog(
                  context: context, 
                  builder: (_) => InfoDialog('Still under construction!'), 
                  barrierDismissible: false),
            ), */
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
            /* ListTile(
              leading: Icon(
                Icons.logout,
                color: myBlue,
              ),
              title: Text(
                'Log out',
                style: TextStyle(color: myBlue),
              ),
              onTap: () {
                // FirebaseAuthService().logoutUser();
                SharedPreferencesHelper().removeData('currentUserData');
                PageRouter().navigateToPage(LoginPage(), context);
              },
            ), */
          ],
        ),
      ),
    );
  }
}
