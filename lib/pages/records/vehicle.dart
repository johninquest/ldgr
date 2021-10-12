import 'package:flutter/material.dart';
import 'package:tba/pages/inputs/vehicle.dart';
import 'package:tba/services/router.dart';
import 'package:tba/styles/style.dart';
import 'package:tba/styles/colors.dart';
import 'package:tba/data/sp_helper.dart';
import 'package:tba/shared/widgets.dart';
import 'package:tba/shared/bottom_nav_bar.dart';
import 'package:tba/services/preprocessor.dart';
import 'package:tba/services/currency.dart';
import 'dart:convert';

class StoredVehiclePage extends StatelessWidget {
  const StoredVehiclePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? currentCountry;
    String? currentCurrency;
    SharedPreferencesHelper().readData('personData').then((value) {
      if(value != null) {
        currentCountry = DataParser().strToMap(value)['country']; 
        currentCurrency = CurrencyHandler().fromCountry(currentCountry);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('My vehicle'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: SharedPreferencesHelper().readData('vehicleData'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String? vData = snapshot.data as String;
            Map vDataStrToMap = jsonDecode(vData);
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTableRow(
                    rowName: 'License plate number',
                    rowData: vDataStrToMap['licensePlateNumber'] ?? '',
                  ),
                  MyTableRow(
                    rowName: 'Chassis number',
                    rowData: vDataStrToMap['chassisNumber'] ?? '',
                  ),
                  MyTableRow(
                    rowName: 'Manufacturer',
                    rowData: vDataStrToMap['maker'] ?? '',
                  ),
                  MyTableRow(
                    rowName: 'Model',
                    rowData: vDataStrToMap['model'] ?? '',
                  ),
                  MyTableRow(
                    rowName: 'First registration date',
                    rowData: vDataStrToMap['firstRegistrationDate'] ?? '',
                  ),
                  MyTableRow(
                      rowName: 'Age', rowData: vDataStrToMap['age'] ?? ''),
                  MyTableRow(
                    rowName: 'Purchase price',
                    rowData:
                        '${showCurrency(currentCurrency, vDataStrToMap["purchasePrice"])}',
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: ElevatedButton(
                                  onPressed: () => PageRouter().navigateToPage(
                                      InputVehiclePage(), context),
                                  child: Text('EDIT'),
                                  style:
                                      ElevatedButton.styleFrom(primary: myBlue),
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: ElevatedButton(
                                  onPressed: () => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Still under construction!')),
                                  ),
                                  child: Text('PRINT'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blueGrey),
                                )),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Vehicle information deleted!')),
                                );
                                SharedPreferencesHelper()
                                    .removeData('vehicleData');
                                PageRouter().navigateToPage(
                                    InputVehiclePage(), context);
                              },
                              child: Text('DELETE'),
                              style: ElevatedButton.styleFrom(primary: myLightRed),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            );
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
          }
        },
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class MyTableRow extends StatelessWidget {
  final String? rowName;
  final String? rowData;
  const MyTableRow({Key? key, this.rowName, this.rowData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: myBlue, width: 1.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 1.0, left: 5.0),
            padding: EdgeInsets.only(bottom: 1.0, left: 5.0),
            child: Text(
              rowName!,
              style: TextStyle(color: myBlue, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 1.0, right: 5.0),
            padding: EdgeInsets.only(bottom: 1.0, right: 5.0),
            child: Text(rowData!.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}

showCurrency(String? currencyCode, String? amount) {
  if (amount != null && amount != '') {
    return '$currencyCode $amount';
  } else
    return '';
}
