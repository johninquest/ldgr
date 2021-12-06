import 'package:flutter/material.dart';
import 'package:ldgr/services/web.dart';
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  'Ldgr',
                  style: TextStyle(
                      color: myBlue,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  'Ldgr is a simple bookkeeping app for bars and restaurants.',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 100.0),
                child: GestureDetector(
                  onTap: () => WebService().openUrl('https://johnapps.de', context),
                  child: Text('\u00A9 $_currentYear JOHN APPS', 
                  style: TextStyle(
                    // fontStyle: FontStyle.italic, 
                    color: myBlue,
                    fontWeight: FontWeight.bold, 
                    decoration: TextDecoration.underline
                    ),),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
