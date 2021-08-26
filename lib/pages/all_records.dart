import 'package:flutter/material.dart';
import 'package:tba/db/sqlite_helper.dart';
import 'package:tba/shared/widgets.dart';

class AllRecordsPage extends StatelessWidget {
  // const AllRecordsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Records'),
        centerTitle: true,
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
    );
  }
}
