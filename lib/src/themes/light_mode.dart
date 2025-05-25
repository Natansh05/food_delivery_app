import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  colorScheme: ColorScheme.light(
    surface: Color(0xFFF5F5F5),
    primary:  Color(0xFFD2D2D2),
    secondary: Color.fromARGB(255, 125, 129, 131), 
    onPrimary: Color(0xFF212121),
    onSurface: Color.fromARGB(255, 70, 70, 70),
  ),

);

