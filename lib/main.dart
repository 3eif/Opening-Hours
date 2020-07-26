import './screens/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    title: 'Opening Hours',
    theme: ThemeData(
      textTheme: GoogleFonts.robotoTextTheme(),
    ),
    home: MainScreen(),
  ));
}
