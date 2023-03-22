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
  static String getUser (){
    return sharedPreferences.getString("user") ?? "";
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