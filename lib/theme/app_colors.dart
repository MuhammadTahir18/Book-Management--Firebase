import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF0F0D1F);
  static const Color surface = Color(0xFF1A1730);
  static const Color card = Color(0xFF231F3A);
  static const Color cardBorder = Color(0xFF2E2A47);
  static const Color primary = Color(0xFFE8C56A);
  static const Color primaryDim = Color(0x28E8C56A);
  static const Color white = Colors.white;
  static const Color grey = Color(0xFF9590A8);
  static const Color iconColor = Color(0xFF7A7590);
  static const Color error = Color(0xFFFF6B6B);
  static const Color success = Color(0xFF4ECDC4);
  static const Color divider = Color(0xFF2A2640);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFE8C56A), Color(0xFFD4A853)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF0F0D1F), Color(0xFF16133A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}