import 'package:tba/db/sp_helper.dart';
import 'package:tba/services/preprocessor.dart';

class CurrencyHandler {
  fromCountry(String? country) {
    switch (country) {
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
      case 'kenya':
        return 'KES';
      case 'lesotho':
        return 'LSL';
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
    if (currency != '' && amount != null && amount != '') {
      return '$currency $amount';
    } else
      return '';
  }

  Future<String?> getCurrencyData() async {
    final rawResponse = await SharedPreferencesHelper().readData('personData');
    Map parsedResponse = DataParser().strToMap(rawResponse);
    String _currency = fromCountry(parsedResponse['country']);
    return _currency;
  }
}
