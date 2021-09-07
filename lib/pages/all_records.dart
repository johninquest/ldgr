import 'package:flutter/material.dart';
import 'package:tba/data/sqlite_helper.dart';
import 'package:tba/pages/bottom_nav_bar.dart';
import 'package:tba/shared/widgets.dart';
// import '../services/router.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:tba/data/models.dart';

class AllRecordsPage extends StatelessWidget {
  // const AllRecordsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SQLiteDatabaseHelper().getExpenditureSum().then((value) {
      // expenditureSum = value['sum_ex'];
      if (value['sum_ex'] != null) {
        expenditureSum = value['sum_ex'];
      } else {
        expenditureSum = 0;
      }
    });
    SQLiteDatabaseHelper().getIncomeSum().then((value) {
      // incomeSum = value['sum_in'];
      if (value['sum_in'] != null) {
        incomeSum = value['sum_in'];
      } else {
        incomeSum = 0;
      }
    });
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
            // print('Response has data!');
            // print(snapshot.data);
            // List<Map> responseData = snapshot.data;
            List responseData = snapshot.data as List;
            return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RecordSummary(),
                ListTitle(),
                Expanded(
                    child: ListView.builder(
                        itemCount: responseData.length,
                        itemBuilder: (context, index) {
                          // print(responseData[index]);
                          String rDate = responseData[index]['created_at'];
                          String rCategory = responseData[index]['category'];
                          String rSource = responseData[index]['source'];
                          double rAmount = responseData[index]['amount'];
                          // return ListItem(rDate, rCategory, rSource, rAmount);
                          return ListItem(rDate, rCategory, rSource, rAmount);
                        }))
              ],
            );
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
            onTap: () => print('Pressed expenses button!')),
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
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.0),
      ),
      decoration: BoxDecoration(
          color: myLabelBackgroundColor,
          borderRadius: BorderRadius.circular(5.0)),
    );
  }
}

double? expenditureSum;
double? incomeSum;

class RecordSummary extends StatelessWidget {
  // const RecordSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 1.0),
      decoration: BoxDecoration(color: Colors.amber),
      height: 80.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              'TOTAL',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue[900]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                    child: Text('EXPENDITURE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.redAccent,
                            letterSpacing: 2.0)),
                  ),
                  Container(
                    child: Text(
                      '$expenditureSum CFA',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue[900]),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    child: Text('INCOME',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent,
                            letterSpacing: 2.0)),
                  ),
                  Container(
                    child: Text(
                      '$incomeSum CFA',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue[900]),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
