import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_assignment/widgets/colors.dart';


void main() {
  test('Hex color without # should be converted correctly', () {
    final color = hexStringToColor("00FF00");
    expect(color, equals(const Color(0xFF00FF00)));
  });

  test('Hex color with # should be converted correctly', () {
    final color = hexStringToColor("#FF0000");
    expect(color, equals(const Color(0xFFFF0000)));
  });

}



