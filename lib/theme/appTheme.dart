import 'package:flutter/material.dart';

class Apptheme {
  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.blue,
      appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 11, 29, 223),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 27),
          iconTheme: IconThemeData(color: Colors.white, size: 35),
          centerTitle: true));
}
