import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'palettes.dart';

extension ExtendedTextStyle on TextStyle {
  TextStyle get light {
    return copyWith(fontWeight: FontWeight.w100);
  }

  TextStyle get regular {
    return copyWith(fontWeight: FontWeight.w400);
  }

  TextStyle get small {
    return copyWith(fontWeight: FontWeight.w300, fontSize: 9);
  }

  TextStyle get italic {
    return copyWith(
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle get medium {
    return copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle get fontHeader {
    return copyWith(
      fontSize: 21,
      height: 22 / 20,
    );
  }

  TextStyle get fontTitle {
    return copyWith(
      fontSize: 18,
      height: 12 / 10,
    );
  }

  TextStyle get semibold {
    return copyWith(fontWeight: FontWeight.w600);
  }

  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.w700);
  }

  // TextStyle get primaryTextColor {
  //   return copyWith(color: Palettes.p7);
  // }

  TextStyle get whiteTextColor {
    return copyWith(color: Colors.white);
  }

  TextStyle get blueTextColor {
    return copyWith(color: Palettes.p8);
  }

  TextStyle get redTextColor {
    return copyWith(color: Palettes.p7);
  }

  TextStyle textSpacing(double num) {
    return copyWith(letterSpacing: num);
  }

  // convenience functions
  TextStyle setColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle setTextSize(double size) {
    return copyWith(fontSize: size);
  }
}

class TextStyles {
  TextStyles(this.context);

  BuildContext? context;

  static TextStyle defaultStyle =
      GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.15, color: Palettes.textBlack);
}

// How to use?
// Text('test text', style: TextStyles.normalText.semibold.whiteColor);
// Text('test text', style: TextStyles.itemText.whiteColor.bold);