import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryRed = Color(0xFFE31837);
  static const Color darkRed = Color(0xFF8B0000);
  static const Color cherryRed = Color(0xFFC41E3A);
  static const Color crimsonRed = Color(0xFFDC143C);
  static const Color burgundy = Color(0xFF800020);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color mediumGray = Color(0xFF9E9E9E);

  static LinearGradient redGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      crimsonRed,
      primaryRed,
      darkRed,
    ],
  );

  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 25,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 10,
      offset: const Offset(0, 5),
    ),
  ];

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.12),
      blurRadius: 20,
      offset: const Offset(0, 8),
      spreadRadius: 2,
    ),
  ];
}
