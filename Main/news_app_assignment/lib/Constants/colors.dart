import 'package:flutter/material.dart';

hexStringToColor(String hexColor){
  hexColor= hexColor.toUpperCase().replaceAll("#", "");
  if(hexColor.length==6){
    hexColor= "FF"+hexColor;
  }
  return Color(int.parse(hexColor,radix: 16));
}

Color appBackground =  hexStringToColor("##f4f6f8");
Color appbarBackground = hexStringToColor("#1858d2");
Color buttonColor = hexStringToColor("#1858d2");