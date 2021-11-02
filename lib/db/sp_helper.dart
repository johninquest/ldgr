import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  Future saveData(String strKey, String strValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(strKey, strValue);
  }

  Future readData(String strKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString(strKey);
    return storedData;
  }

  Future removeData(String strKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(strKey);
  }

    Future storeData(String strKey, String strValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(strKey, strValue);
  }
}
