import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.grey,// Primary Color (Blue)
    primary:  Color(0xFF8888E7),// Secondary Color (Blue Grey)
    secondary: Color(0xFFFFA000), // Tertiary Color (Amber)
    onPrimary: Colors.white, // Inverse Primary Color (White)
  ),
);
