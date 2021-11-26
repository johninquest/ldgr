import 'package:flutter/material.dart';
import 'package:ldgr/db/sp_helper.dart';
import 'package:ldgr/services/currency.dart';
import 'package:ldgr/shared/bottom_nav_bar.dart';
import 'package:ldgr/shared/lists.dart';
import 'package:ldgr/shared/snackbar_messages.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key}) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  final _countryFormKey = GlobalKey<FormState>();
  String? _country;
  TextEditingController _currency = TextEditingController();

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper().readData('countryName').then((value) {
      if (value != null) {
        setState(() {
          _country = value;
          _currency.text = CurrencyHandler().fromCountry(_country);
        });
      } else {
        print('No country data found!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select country'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: _countryFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.90,
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: DropdownButtonFormField(
                  value: _country,
                  isExpanded: true,
                  decoration: InputDecoration(labelText: 'Country'),
                  items: MyItemList().countryList,
                  validator: (val) =>
                      val == null ? 'Please select country' : null,
                  onChanged: (val) => setState(() {
                    _country = val as String?;
                    _currency.text = CurrencyHandler().fromCountry(_country);
                    saveSelectedCountry(_country, context);
                  }),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.90,
                margin: EdgeInsets.only(bottom: 5.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                child: TextFormField(
                  controller: _currency,
                  enabled: false,
                  decoration: InputDecoration(labelText: 'Currency'),
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

saveSelectedCountry(String? countryValue, context) async {
  if (countryValue != null && countryValue.runtimeType == String) {
    await SharedPreferencesHelper().saveData('countryName', countryValue);
  } else
    return SnackBarMessage().generalErrorMessage(context);
}
