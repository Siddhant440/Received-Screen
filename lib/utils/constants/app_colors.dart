import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6754FF); // Adjusted to match image
  static const Color background = Color(0xFFF9F8FF); // Lighter background
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color textPrimary = Color(0xFF484C52);
  static const Color border = Color(0xFFDADADA); // Lighter border
  static const Color menuBorder = Color(0xFFAEBFED);

  // Bottom navbar colors
  static const Color navbarBackground = Color(0xFF1F1F1F);
  static const Color navbarLightBackground = Colors.white;
  static const Color navIconGrey = Color(0xFF9E9E9E);
  static const Color navIconLightGrey = Color(0xFF484C52);

  // Gradient for selected items
  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFF6754FF), Color(0xFF6754FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
