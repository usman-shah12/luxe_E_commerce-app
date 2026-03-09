import 'package:flutter/material.dart';

class AppColors {
  // Backgrounds
  static const bgDark = Color(0xFF0A0A0F);
  static const bgCard = Color(0xFF12121A);
  static const bgSurface = Color(0xFF1A1A26);
  static const bgElevated = Color(0xFF22223A);

  // Accent - Electric Violet / Gold
  static const primary = Color(0xFF7C3AED);
  static const primaryLight = Color(0xFF9D5CFF);
  static const primaryDark = Color(0xFF5B21B6);
  static const gold = Color(0xFFD4AF37);
  static const goldLight = Color(0xFFFFD700);

  // Text
  static const textPrimary = Color(0xFFF0F0FF);
  static const textSecondary = Color(0xFF9090B0);
  static const textMuted = Color(0xFF5A5A7A);
  static const textAccent = Color(0xFF9D5CFF);

  // Status
  static const success = Color(0xFF10B981);
  static const error = Color(0xFFEF4444);
  static const warning = Color(0xFFF59E0B);

  // Gradients
  static const gradientPrimary = LinearGradient(
    colors: [Color(0xFF7C3AED), Color(0xFFDB2777)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientGold = LinearGradient(
    colors: [Color(0xFFD4AF37), Color(0xFFFFD700), Color(0xFFB8860B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientCard = LinearGradient(
    colors: [Color(0xFF1A1A26), Color(0xFF12121A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const gradientBanner = LinearGradient(
    colors: [Color(0xFF0A0A0F), Colors.transparent],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  // Borders
  static const borderColor = Color(0xFF2A2A40);
  static const borderGlow = Color(0x557C3AED);
}
