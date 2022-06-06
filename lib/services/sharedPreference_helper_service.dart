import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {


   static Future<void> setUserToken({required String value,required String key}) async {
         SharedPreferences _prefs = await SharedPreferences.getInstance();
     await _prefs.setString(key, value);
   }

  static Future<String?> getUserToken({required String key})async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
     final userToken = _prefs.getString(key);
     return userToken;
   }
}
