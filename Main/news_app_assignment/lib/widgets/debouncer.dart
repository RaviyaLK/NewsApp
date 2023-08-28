import 'dart:async';
import 'package:flutter/material.dart';



class Debouncer {//debounces the search bar
  final int milliseconds;
  Timer? timer;

  Debouncer({this.milliseconds = 1000});

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action); //waits for 1 second before executing the action
  }
}