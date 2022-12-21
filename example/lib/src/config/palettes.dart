import 'package:flutter/material.dart';

class Palettes {
  /// Text colors
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textBlack = Color(0xFF000000);

  /// Main palettes
  static const Color p1 = Color(0xFF191919);
  static const Color p2 = Color(0xFF2D4263);
  static const Color p3 = Color(0xFFC84B31);
  static const Color p4 = Color(0xFFECDBBA);

  /// Sub palettes
  static const Color p5 = Color(0xFFC0D8C0);
  static const Color p6 = Color(0xFFECB390);
  static const Color p7 = Color(0xFFf80762);
  static const Color p8 = Color(0xFF58adf1);
  static const Color p9 = Color(0xFFC0D8C0);
  static const Color p10 = Colors.redAccent;
  static const Color p11 = Colors.blueAccent;

  /// Sub palettes
  static const Color p12 = Color(0xFFABC9FF);
  static const Color p13 = Color(0xFFFFDEDE);
  static const Color p14 = Color(0xFFFF8B8B);
  static const Color p15 = Color(0xFFEB4747);
  static const Color p16 = Color(0xFFC0D8C0);

  /// gradient
  static const Gradient gradientAppBar = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Palettes.p7,
      Palettes.p8,
    ],
  );
  static const Gradient gradientBoxCus = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Palettes.p10,
      Palettes.p11,
    ],
  );
  static const Gradient gradientCircle = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Color(0xFFffff99),
      Color(0xFFff99cc),
    ],
  );
  static const Gradient gradientBtn = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[
      Color(0xFF3399ff),
      Color(0xFFff99cc),
    ],
  );
}
