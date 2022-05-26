import 'package:flutter/material.dart';
import 'package:ldgr/services/web.dart';
import 'package:ldgr/shared/app_info.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/styles/colors.dart';
import 'package:ldgr/styles/style.dart';
import 'package:ldgr/services/date_time_helper.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _currentYear = DateTimeHelper().currentYear(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About app',
          style: AppBarTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.width * 0.95,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  'Ldgr',
                  style: TextStyle(
                      color: myBlue,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ),
              ),
              Divider(
                indent: 100.0,
                endIndent: 100.0,
                thickness: 1.0,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, bottom: 75.0, top: 10.0),
                child: Text(
                  'Ldgr is a simple bookkeeping app for your catering business.',
                  textAlign: TextAlign.center,
                  style: TextStyle(letterSpacing: 0.5),
                ),
              ),
              // SizedBox(height: 50.0,),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () =>
                      WebService().openUrl('https://johnapps.de', context),
                  child: Text(
                    '\u00A9 $_currentYear JOHN APPS',
                    style: TextStyle(color: myBlue, letterSpacing: 0.5
                        // decoration: TextDecoration.underline
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              AppInfo()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
