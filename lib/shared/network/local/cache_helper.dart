

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

 static SharedPreferences? sharedPreferences;

 static Future init() async{
   return sharedPreferences = await SharedPreferences.getInstance();
 }

 static Future<bool> putData({
   required String key,
   required bool value,
})async{
  return await sharedPreferences!.setBool(key, value);
 }

 static bool? getData({
   required String key,
}){
   return  sharedPreferences!.getBool(key);
 }
}



//https://newsapi.org/
// v2/everything
// q=tesla&apiKey=36ee2a698b4f4169a5103865971687ee