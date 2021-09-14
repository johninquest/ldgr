import 'package:flutter/material.dart';
import 'package:tba/pages/inputs/vehicle.dart';
import 'package:tba/services/router.dart';
import 'package:tba/styles/style.dart';
import 'package:tba/styles/colors.dart';
import 'package:tba/data/sp_helper.dart';
import 'package:tba/shared/widgets.dart';
import 'dart:convert';

class StoredVehiclePage extends StatelessWidget {
  const StoredVehiclePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My vehicle'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SharedPreferencesHelper().readData('vehicleData'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('Snapshot returned data');
            String? vData = snapshot.data as String;
            Map vStrToMap = jsonDecode(vData);
            print(vData.runtimeType);
            print(vStrToMap['chassisNumber']);
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('$vData'), 
                 Container(
                        child: ElevatedButton(
                      onPressed: () => PageRouter()
                          .navigateToPage(InputVehiclePage(), context),
                      child: Text('UPDATE'),
                      style: ElevatedButton.styleFrom(primary: myBlue),
                    ))

              ]
                ));
          }
          if (snapshot.hasError) {
            return ErrorOccured();
          } else {
            return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'No vehicle information was found!',
                        style: BodyStyle,
                      ),
                    ),
                    Container(
                        child: ElevatedButton(
                      onPressed: () => PageRouter()
                          .navigateToPage(InputVehiclePage(), context),
                      child: Text('ADD VEHICLE'),
                      style: ElevatedButton.styleFrom(primary: myBlue),
                    ))
                  ],
                ));
            //PageRouter().navigateToPage(InputVehiclePage(), context);
          }
        },
      ),
    );
  }
}
