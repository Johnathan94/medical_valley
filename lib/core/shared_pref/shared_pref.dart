import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageManager {
  static late SharedPreferences sharedPreferences ;
  static initialize ()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static saveUser (Map<String, dynamic> userDate)async{
    await sharedPreferences.setString("user", jsonEncode(userDate));
  }
  static saveToken (String token)async{
    await sharedPreferences.setString("token", token);
  }
  static Map<String , dynamic >? getUser (){
    String user = sharedPreferences.getString("user") ?? "";

    Map<String , dynamic > currentUser = {} ;
    if(user != "") {
      currentUser =  jsonDecode(user);
      return currentUser;
    }
    return null;
  }
  static Future saveCurrentLanguage (String locale)async{
    await sharedPreferences.setString("locale", locale);
  }
  static String getCurrentLanguage (){
    return sharedPreferences.getString("locale") ?? "";
  }
  static saveNegotiationCount ()async{
    await sharedPreferences.setInt("nego_count", getNegotiationCount()+1);
  }
  static resetNegotiationCount ()async{
    await sharedPreferences.setInt("nego_count", 0);
  }
  static int getNegotiationCount (){
    return sharedPreferences.getInt("nego_count") ?? 0;
  }
  static deleteUser ()async{
    await sharedPreferences.setString("user","");
  }
  static  remove ()async{
    await sharedPreferences.clear();
  }

}