import 'package:flutter/material.dart';

class Appwidget {
  static TextStyle boldTextFeildStyle() {
    return TextStyle(
      color: Color(0xFF333333),
      fontWeight: FontWeight.bold,
      fontSize: 20,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle headlineTextFeildStyle() {
    return TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 25,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle lightTextFeildStyle() {
    return TextStyle(
      color: Colors.black38,
      fontWeight: FontWeight.w800,
      fontSize: 15.0,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle semiBoldTextFeildStyle() {
    return TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w900,
      fontSize: 18.0,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle loginTextFeildStyle() {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w900,
      fontSize: 30.0,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle loginsemiTextFeildStyle() {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w900,
      fontSize: 15.0,
      fontFamily: 'Poppins',
    );
  }

  static TextStyle accountTextFeildStyle() {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w900,
      fontSize: 13.5,
      fontFamily: 'Poppins',
    );
  }
}

class ColorConstants {
  static final Color secondarycolor = Colors.white;
  static final Color primarycolor = Colors.white;
  static final Color textcolor = Colors.black;
}

// everything must be in constants
