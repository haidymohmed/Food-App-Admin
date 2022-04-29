import 'package:flutter/material.dart';
class UserResponsive{
  static get({context , mobile , tablet}){
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.width;
    if(w > 600){
      return tablet;
    }else{
      return mobile;
    }

  }
}