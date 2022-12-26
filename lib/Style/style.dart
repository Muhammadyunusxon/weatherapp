import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Style{
  Style._();

  // ------------------ Colors -----------------//

  static const whiteColor = Color(0xffFFFFFF);
  static const blackColor = Color(0xff000000);
  static const primaryColor =Color(0xffF2F2F7);
  static const brandColor =Color(0xff3E2A7E);
  static const secondaryColor =Color(0xff2E335A);
  static const textColor =Color(0xff9F9FA5);


  // ------------------ Gradient -----------------//
  static const primaryGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0x0D3A3F54),
        Color(0xB33A3F54),
        Color(0xff3A3F54),
        Color(0xff3A3F54),
      ]);
  static const secondaryGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xffE8E8E8),
        Color(0xffCDCDCD),
      ]);

  // ------------------ Gradient -----------------//
  static List<BoxShadow> hourlyShadow = [
    BoxShadow(
      offset: const Offset(5, 4),
      color: Style.blackColor.withOpacity(0.25),
      blurRadius: 10,
    ),
    BoxShadow(
      offset: const Offset(1,1),
      color: Style.whiteColor.withOpacity(0.1),
    )
  ];


  static textStyleNormal(
      {double size = 16, Color textColor = primaryColor, bool isDone = false}) {
    return GoogleFonts.manrope(
        fontSize: size,
        color: textColor,
        fontWeight: FontWeight.normal,
        decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none);
  }

  static textStyleSemiBold(
      {double size = 16, Color textColor = primaryColor, bool isDone = false}) {
    return GoogleFonts.manrope(
        fontSize: size,
        color: textColor,
        fontWeight: FontWeight.w600,
        decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none);
  }

  static textStyleBold(
      {double size = 18, Color textColor = primaryColor, bool isDone = false}) {
    return GoogleFonts.manrope(
        fontSize: size,
        color: textColor,
        fontWeight: FontWeight.bold,
        decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none);
  }

  static textStyleRegular(
      {double size = 16, Color textColor = primaryColor, bool isDone = false}) {
    return GoogleFonts.manrope(
        fontSize: size,
        color: textColor,
        fontWeight: FontWeight.w400,
        decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none);
  }

  static textStyleThin(
      {double size = 16, Color textColor = primaryColor, bool isDone = false}) {
    return GoogleFonts.manrope(
        fontSize: size,
        color: textColor,
        fontWeight: FontWeight.w300,
        decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none);
  }

}