import 'package:shared_preferences/shared_preferences.dart';

class HelperFunc
{
  static String loggedInKey = "ISLOGGEDIN";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

  //saving data
  static Future<bool> saveUserloggedIn(bool isUserLoggedIn) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setBool(loggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUsername(String username) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(userNameKey, username);
  }

  static Future<bool> saveUserEmail(String email) async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(userEmailKey, email);
  }

  //get data
  static Future<bool> getUserloggedIn() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getBool(loggedInKey);
  }

  static Future<String> getUsername() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getString(userNameKey);
  }

  static Future<String> getUserEmail() async
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getString(userEmailKey);
  }
  
}