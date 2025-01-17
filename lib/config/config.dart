import 'dart:convert';

import 'package:flutter/services.dart';

//import config.json

//add  static front of configuration to use it without create object
class Configuration{
  static Future <Map<String, dynamic>> getConfig(){
    return rootBundle.loadString('assets/images/config/config.json').then(
    (value){
      //convert string to object 
      return jsonDecode(value) as Map<String, dynamic>;
    },
    );
  }
}