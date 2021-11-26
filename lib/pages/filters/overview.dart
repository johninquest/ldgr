import 'package:flutter/material.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/pages/records/all.dart';
import 'package:ldgr/styles/colors.dart';
import 'package:ldgr/services/router.dart';

class FilterOverview extends StatelessWidget {
  const FilterOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter options'),
        centerTitle: true, 
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilterButton(buttonName: 'today'), 
            FilterButton(buttonName: 'week'), 
            FilterButton(buttonName: 'month'), 
            FilterButton(buttonName: 'year'), 
            FilterButton(buttonName: 'from / to'), 
            FilterButton(buttonName: 'all'),
          ],
        ),
      ),
      // floatingActionButton: FloatingSideMenu(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String buttonName;
  const FilterButton({Key? key, required this.buttonName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width * 0.75, 
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      child: ElevatedButton(
        onPressed: () => localNavigator(buttonName, context),
        child: Text('$buttonName'.toUpperCase()),
        style: ElevatedButton.styleFrom(primary: myBlue),
      ),
    );
  }
}

localNavigator(String bName, context) {
  if (bName == 'all') {
    Widget targetPage = AllRecords();
    PageRouter().navigateToPage(targetPage, context);
  } else {
    print('Route coming soon');
  }
}
