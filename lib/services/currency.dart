import 'dart:convert';

import 'package:tba/data/sp_helper.dart'; 

class CurrencyHandler {

  String? currentCountry; 

  getCountry() {
    SharedPreferencesHelper().readData('personData').then((value) {
      if(value != null) {
        currentCountry = parsePersonData(value)['country'];
      }
    });
  }

  parsePersonData(String? personStr) {
  if (personStr != null) {
    Map strToMap = jsonDecode(personStr);
    return strToMap;
  } else {
    return {};
  }
}

  

  fromCountry(String? country) {
    switch (country) {
      case 'burundi':
        return 'BIF';
      case 'cameroon':
        return 'XAF';
      case 'ethiopia':
        return 'ETB';
      case 'eswatini':
        return 'SZL';
      case 'ghana':
        return 'GHS';
      case 'gambia':
        return 'GMD';
      case 'kenya':
        return 'KES';
      case 'liberia':
        return 'LRD';
      case 'malawi':
        return 'MWK';
      case 'mauritius':
        return 'MUR';
      case 'nigeria':
        return 'NGN';
      case 'rwanda':
        return 'RWF';
      case 'seychelles':
        return 'SCR';
      case 'sierra_leone':
        return 'SLL';
      case 'south_africa':
        return 'ZAR';
      case 'south_sudan':
        return 'SSP';
      case 'sudan':
        return 'SDG';
      case 'tanzania':
        return 'TZS';
      case 'uganda':
        return 'UGX';
      case 'zambia':
        return 'ZMW';
      default:
        return '';
    }
  }


  addCurrencyToAmount(String? currency, String? amount) {
    if (currency != '') {
      return '$currency $amount';
    } else
      return '';
  }
}
