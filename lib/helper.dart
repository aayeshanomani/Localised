import 'package:shared_preferences/shared_preferences.dart';

class Helper
{
  static String loggedInKey = "ISLOGGEDIN";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";

  //saving data
  static Future<void> saveUserloggedIn(bool isUserLoggedIn) async 
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setBool(loggedInKey, isUserLoggedIn);
  }

  static Future<void> saveUsername(String username) async 
  {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(userNameKey, username);
  }

  
}