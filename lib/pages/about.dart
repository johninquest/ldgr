import 'package:flutter/material.dart';
import '../services/date_time_helper.dart';
import '../services/web.dart';
import '../shared/app_version_info.dart';
import '../shared/bottom_nav_bar.dart';
import '../styles/colors.dart';
import '../styles/style.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _currentYear = DateTimeHelper().currentYear(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'about',
          style: AppBarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.width * 0.95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          /* mainAxisSize: MainAxisSize.max, */
          children: [
            Spacer(),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                'Ldgr',
                style: TextStyle(
                    color: myBlue,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0),
              ),
            ),
            Divider(
              indent: 110.0,
              endIndent: 110.0,
              thickness: 1.0,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: 10.0, right: 10.0, bottom: 50.0, top: 10.0),
              child: Text(
                'Ldgr is the single-entry bookkeeping app for your small one-man business.',
                textAlign: TextAlign.center,
                style: TextStyle(letterSpacing: 0.5),
              ),
            ),
            // SizedBox(height: 50.0,),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: GestureDetector(
                onTap: () =>
                    WebService().openUrl('https://johnapps.de', context),
                child: Text(
                  '\u00A9 JOHN APPS $_currentYear',
                  style: TextStyle(
                    color: myBlue,
                    letterSpacing: 0.1,
                    wordSpacing: 1.0,
                    fontSize: 11.0,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 0.5,
              ))),
            ),
            Spacer(
              flex: 2,
            ),
            AppInfo(),
            /*    Positioned(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Text('Hello'))), */
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
