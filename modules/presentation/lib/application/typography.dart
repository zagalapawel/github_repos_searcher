import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle extends TextStyle {
  AppTextStyle._style(TextStyle style)
      : super(
          inherit: style.inherit,
          color: style.color,
          backgroundColor: style.backgroundColor,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          fontStyle: style.fontStyle,
          letterSpacing: style.letterSpacing,
          wordSpacing: style.wordSpacing,
          textBaseline: style.textBaseline,
          height: style.height,
          leadingDistribution: style.leadingDistribution,
          locale: style.locale,
          foreground: style.foreground,
          background: style.background,
          shadows: style.shadows,
          fontFeatures: style.fontFeatures,
          decoration: style.decoration,
          decorationColor: style.decorationColor,
          decorationStyle: style.decorationStyle,
          decorationThickness: style.decorationThickness,
          debugLabel: style.debugLabel,
          fontFamily: style.fontFamily,
          fontFamilyFallback: style.fontFamilyFallback,
        );
}

abstract class AppTextStyles {
  const AppTextStyles._();

  static final heading1 = AppTextStyle._style(
    GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 18,
    ),
  );
  static final heading2 = AppTextStyle._style(
    GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
  );

  static final heading3 = AppTextStyle._style(
    GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
  );

  static final bodyText = AppTextStyle._style(
    GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
  );

  static final information = AppTextStyle._style(
    GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
  );

  static final informationSmall = AppTextStyle._style(
    GoogleFonts.poppins(
      fontWeight: FontWeight.w400,
      fontSize: 10,
    ),
  );

  static final buttonText = AppTextStyle._style(
    GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
  );
}
