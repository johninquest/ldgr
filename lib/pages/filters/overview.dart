import 'package:flutter/material.dart'; 
import 'package:tba/pages/bottom_nav_bar.dart';

class FilterOverview extends StatelessWidget {
  const FilterOverview({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overview'), 
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Hello world!')
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}