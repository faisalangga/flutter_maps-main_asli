import 'package:shared_preferences/shared_preferences.dart';

class LocalData{

  static Future<bool> removeAllPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static void saveDataBool(String param, bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(param, val);
  }

  static Future<bool> getDataBool(String param) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getBool(param);
    if (data != null) {
      return data;
    }
    return false;
  }

  static void saveData(String param, String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(param, val);
  }

  static Future<String> getData(String param) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(param);
    if (data != null && data.isNotEmpty) {
      return data;
    }
    return '';
  }

  static void saveDataInt(String param, int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(param, val);
  }

  static Future<int> getDataInt(String param) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getInt(param);
    if (data != null) {
      return data;
    }
    return -1;
  }

  static Future<bool> removeData(String param) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(param);
  }
}