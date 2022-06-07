import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

Color primaryColor = const Color(0xFF7e70ff);

class Themes {
  static ThemeData light = FlexColorScheme.light(
    colors: FlexSchemeColor.from(primary: primaryColor),
  ).toTheme;
  static ThemeData dark = FlexColorScheme.dark(
    colors: FlexSchemeColor.from(primary: primaryColor),
    scaffoldBackground: Colors.black,
  ).toTheme;
}

String apiKey = '5bbf5d2d8272c8a9741563d98a1aadaa';
