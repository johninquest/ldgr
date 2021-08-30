import 'package:flutter/material.dart';
import 'package:tba/db/sqlite_helper.dart';
import 'package:tba/pages/bottom_nav_bar.dart';
import 'package:tba/shared/widgets.dart';
// import '../services/router.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class AllRecordsPage extends StatelessWidget {
  // const AllRecordsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Records'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: SQLiteDatabaseHelper().getAllRows(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('Response has data!');
            // print(snapshot.data);
            // List<Map> responseData = snapshot.data;
            List responseData = snapshot.data as List;
            print(responseData.length);
            // List? parsedData = responseData.toList();
            // print(responseData.runtimeType);
            // return Center(child: Text('$responseData'));
            return Column(
                children: [
                   ListTitle(),
                   Expanded(
                     child: ListView.builder(
                      itemCount: responseData.length,
                      itemBuilder: (context, index) {
                        // print(responseData[index]);
                        String rDate = responseData[index]['created_at'];
                        String rCategory = responseData[index]['category'];
                        String rSource = responseData[index]['source'];
                        String rAmount = responseData[index]['amount'];
                        // return ListItem(rDate, rCategory, rSource, rAmount);
                        return ListItem(rDate, rCategory, rSource, rAmount);
                      }))
                ],
              
            );
/*             return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTitle(),
                // Center(child: Text('$responseData'),)
                ListView.builder(
                    itemCount: responseData.length,
                    itemBuilder: (context, index) {
                      print(responseData[index]);
                      String rDate = responseData[index]['created_at'];
                      String rCategory = responseData[index]['category'];
                      String rSource = responseData[index]['created_at'];
                      String rAmount = responseData[index]['created_at'];
                      // return ListItem(rDate, rCategory, rSource, rAmount);
                      return Text('Hallo welt!');
                    })
              ],
            ); */
          }
          if (snapshot.hasError) {
            print('Reponse has error!');
            return ErrorOccured();
          }
          return SizedBox();
        },
      ),
      floatingActionButton: SideButtomMenu(),  
      bottomNavigationBar: BottomNavBar(),
    );
  }
}


class SideButtomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      children: [
        SpeedDialChild(
          labelWidget: MyLabelWidget('Expenditure', Colors.redAccent),
          // onTap: () => PageRouter().navigateToPage(InputExpenditurePage(), context),
          onTap: () => print('Pressed expenses button!')
        ),
        SpeedDialChild(
            labelWidget: MyLabelWidget('Income', Colors.greenAccent),
            onTap: () => print('Pressed income button!') 
            // onTap: () => PageRouter().navigateToPage(InputIncomePage(), context),
            ), 
        /* SpeedDialChild(
            labelWidget: MyLabelWidget('Records', Colors.black),
            onTap: () => PageRouter().navigateToPage(AllRecordsPage(), context),
            ),     */
      ],
    );
  }
}

class MyLabelWidget extends StatelessWidget {
  final String myLabelName;
  final Color myLabelBackgroundColor;
  MyLabelWidget(this.myLabelName, this.myLabelBackgroundColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: Text(
        myLabelName,
        style: TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.0),
      ),
      decoration: BoxDecoration(
          color: myLabelBackgroundColor,
          borderRadius: BorderRadius.circular(5.0)),
    );
  }
}

