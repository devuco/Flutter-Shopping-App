import 'package:flutter/material.dart';

class Utils {
  static Color getColor(String? hexColor) {
    return Color(int.parse(hexColor?.replaceAll('#', '0xff') ?? '0xfff'));
  }
}
