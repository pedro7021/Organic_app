import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Color(0xFF166A34),
      ),
      elevation: 6,
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Color(0xFF166A34),
        ),
      ),
    ),
    primaryColor: const Color(0xFF166A34),
    accentColor:  const Color(0xFF40AC00),
  );
}
