import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color canvasBg = Color(0xFFECE8DF);
  static const Color cardBg = Color(0xFFDBD7CE);
  static const Color ink = Color(0xFF111111);
  static const Color accentWhite = Color(0xFFFAF9F6);
  static const Color blueAccent = Color(0xFF3B82F6);
  static const Color dividerColor = Color(0x26000000); // 15% black
}

class AppTypography {
  static TextStyle headingLarge({Color color = AppColors.ink}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 24,
      fontWeight: FontWeight.w900,
      letterSpacing: 1.5,
      color: color,
      height: 1.0,
    );
  }

  static TextStyle headingMedium({Color color = AppColors.ink}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 18,
      fontWeight: FontWeight.w900,
      letterSpacing: 0.5,
      color: color,
      height: 1.25,
    );
  }

  static TextStyle headingSub({Color color = AppColors.ink}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 14.5,
      fontWeight: FontWeight.w800,
      color: color,
      height: 1.2,
    );
  }

  static TextStyle monoBadge({Color color = AppColors.ink}) {
    return GoogleFonts.spaceMono(
      fontSize: 27,
      fontWeight: FontWeight.w700,
      letterSpacing: 2.0,
      color: color,
      height: 1.0,
    );
  }

  static TextStyle monoBody({
    Color color = AppColors.ink,
    double fontSize = 13.5,
    FontWeight fontWeight = FontWeight.w400,
    double height = 1.45,
  }) {
    return GoogleFonts.spaceMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  static TextStyle monoPill({Color color = AppColors.ink}) {
    return GoogleFonts.spaceMono(
      fontSize: 12.5,
      fontWeight: FontWeight.w400,
      color: color,
    );
  }
}
