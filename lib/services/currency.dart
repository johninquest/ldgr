import 'package:tba/db/sp_helper.dart';

class CurrencyHandler {
  fromCountry(String? country) {
    switch (country) {
      case 'algeria':
        return 'DZD';
      case 'angola':
        return 'AOA';
      case 'burundi':
        return 'BIF';
      case 'botswana':
        return 'BWP';
      case 'cameroon':
      case 'central_african_republic':
      case 'chad':
      case 'congo_republic':
      case 'equatorial_guinea':
      case 'gabon':
        return 'XAF';
      case 'benin':
      case 'burkina_faso':
      case 'guinea_bissau':
      case 'ivory_coast':
      case 'mali':
      case 'niger':
      case 'senegal':
      case 'togo':
        return 'XOF';
      case 'congo_drc':
        return 'CDF'; 
      case 'djibouti':
        return 'DJF'; 
      case 'egypt':
        return 'EGP';      
      case 'eritrea':
        return 'ERN';
      case 'ethiopia':
        return 'ETB';
      case 'eswatini':
        return 'SZL';
      case 'ghana':
        return 'GHS';
      case 'gambia':
        return 'GMD'; 
      case 'guinea':
        return 'GNF';  
      case 'kenya':
        return 'KES';
      case 'lesotho':
        return 'LSL';
      case 'liberia':
        return 'LRD'; 
      case 'libya':
        return 'LYD';  
      case 'malawi':
        return 'MWK';
      case 'mauritius':
        return 'MUR'; 
      case 'morocco':
        return 'MAD'; 
      case 'mozambique':
        return 'MZN';   
      case 'namibia':
        return 'NAD';  
      case 'nigeria':
        return 'NGN';
      case 'rwanda':
        return 'RWF';
      case 'seychelles':
        return 'SCR';
      case 'sierra_leone':
        return 'SLL';
      case 'somalia':
        return 'SOS';  
      case 'south_africa':
        return 'ZAR';
      case 'south_sudan':
        return 'SSP';
      case 'sudan':
        return 'SDG';
      case 'tanzania':
        return 'TZS'; 
      case 'tunisia':
        return 'TND';  
      case 'uganda':
        return 'UGX';
      case 'zambia':
        return 'ZMW';
      default:
        return '';
    }
  }

  addCurrencyToAmount(String? currency, String? amount) {
    if (currency != '' && amount != null && amount != '') {
      return '$currency $amount';
    } else
      return '';
  }

  Future<String?> getCurrencyData() async {
    final responseData = await SharedPreferencesHelper().readData('countryName');
    String _currency = fromCountry(responseData);
    return _currency;
  }
}
