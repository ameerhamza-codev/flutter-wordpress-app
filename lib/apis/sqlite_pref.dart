import 'package:shared_preferences/shared_preferences.dart';

class SqlitePref{
  static const FIRSTTIME="FIRSTTIME";

  static Future setFirstTime(bool value)async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(FIRSTTIME, value);
  }

  static Future<bool> isFirstTime()async{
    final prefs = await SharedPreferences.getInstance();
    bool value = await prefs.getBool(FIRSTTIME)??true;
    return value;
  }
}
