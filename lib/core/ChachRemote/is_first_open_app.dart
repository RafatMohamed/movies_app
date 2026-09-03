import 'dart:developer';

import 'package:movies_app/core/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IsFirstOpenApp {
 static SharedPreferences? _pref ;
 static Future<void> initSharedStorge ()async{
   _pref= await SharedPreferences.getInstance();
 }

 static Future<void> setIsFirstOpen (bool value)async{
   try{
     _pref!.setBool(AppConstChach.isFirstOpenApp, value);
   }catch(error){
     log("error to save is first open");
   }
 }

 static bool getIsFirstOpen (){
   try{
   return  _pref!.getBool(AppConstChach.isFirstOpenApp)??false;
   }catch(error){
     log("error to get is first open");
     rethrow;
   }
 }
}