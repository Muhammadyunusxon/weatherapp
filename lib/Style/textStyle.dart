import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/Style/style.dart';

class PrimaryTextStyle {
  PrimaryTextStyle._();

  static normal({
    double size = 16,
    Color textColor = Style.primaryColor,
  }) {
    return GoogleFonts.manrope(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.normal,
    );
  }

  static semiBold({
    double size = 16,
    Color textColor = Style.primaryColor,
  }) {
    return GoogleFonts.manrope(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.w600,
    );
  }

  static bold({
    double size = 18,
    Color textColor = Style.primaryColor,
  }) {
    return GoogleFonts.manrope(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.bold,
    );
  }

  static regular({
    double size = 16,
    Color textColor = Style.primaryColor,
  }) {
    return GoogleFonts.manrope(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.w400,
    );
  }

  static thin({
    double size = 16,
    Color textColor = Style.primaryColor,
  }) {
    return GoogleFonts.manrope(
      fontSize: size,
      color: textColor,
      fontWeight: FontWeight.w300,
    );
  }
}
