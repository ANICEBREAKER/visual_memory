import 'package:flutter/material.dart';

/// App-wide color palette: deep blue modern base, 2 themes, 3 button colors, semantic, text, border.
class AppColors {
  // --- CORE & GLOBAL ---
  static const Color transparent = Color(
    0x00000000,
  ); // Replaces direct Colors.transparent usage

  // --- LIGHT THEME ---
  // Updated pastel pink palette: background (very light), surface (light), primary (soft accent), secondary (stronger accent)
  static const Color surfaceLight = Color(
    0xFFFDE4EC,
  ); // light pastel pink surface
  // A card surface that sits visually between backgroundLight and surfaceLight.
  // Computed roughly as the midpoint of the two: avg(FFF7FA, FDE4EC) ≈ FEEEF3
  static const Color cardLight = Color(
    0xFFFEEEF3,
  ); // elevated card on light theme
  static const Color backgroundLight = Color(
    0xFFFFF7FA,
  ); // near-white pink-tinted background
  static const Color primaryLight = Color(0xFFF48FB1); // Pink 200 style primary
  static const Color secondaryLight = Color(0xFFEC407A); // Pink 400 accent

  // --- DARK THEME ---
  static const Color backgroundDark = Color(0xFF141C34); // Deep navy
  static const Color surfaceDark = Color(0xFF162147); // Slightly lighter navy
  static const Color cardDark = Color(0xB122305B); // Card surface
  // Bright sky blue that stands out on deep navy backgrounds
  // static const Color primaryDark = Color(0xFF38BDF8); // Sky 400-ish
  // Lighter sky-blue accent that stays blue/cyan-ish and distinct from primaryDark
  static const Color secondaryDark = Color(0xFF22D3EE); // Sky 300-ish
  static const Color primaryDark = Color(
    0xFF1f8fff,
  ); // Custom bright blue for dark theme
  // --- BUTTON COLORS (shared) ---
  static const Color buttonCyan = Color(0xFF1f8fff); // Vibrant cyan
  static const Color buttonOrange = Color(0xFFff6d1f); // Vibrant orange
  static const Color buttonPurple = Color(0xFF681b98); // Vibrant purple
  // --- LIGHT-THEME BUTTON TRIO (pastel variants) ---
  static const Color buttonLightCyan = Color(
    0xFFfaa09e,
  ); // pastel cyan from palette
  static const Color buttonLightOrange = Color(0xFFfac9a3); // pastel peach
  static const Color buttonLightPurple = Color(0xFFF6E4B6); // pastel yellow
  // --- SEMANTIC COLORS ---
  static const Color success = Color(0xFF009f42);
  // static const Color error = Color(0xFFb41c2b);
  static const Color error = Color(0xffff443a);

  static const Color warning = Color(0xFFf0ad4e);
  static const Color info = Color(0xFF388cfa); // Use cyan for info

  // --- TEXT COLORS ---
  static const Color textPrimaryLight = Color.fromARGB(
    255,
    52,
    73,
    105,
  ); // Deep gray
  static const Color textSecondaryLight = Color.fromARGB(
    255,
    227,
    239,
    252,
  ); // Off-white
  static const Color textDisabledLight = Color(0xFF94A3B8);
  static const Color textPrimaryDark = Color.fromARGB(
    255,
    222,
    236,
    248,
  ); // Off-white
  static const Color textSecondaryDark = Color(0xFFE2E8F0);
  static const Color textDisabledDark = Color(0xFF64748B);

  // --- BORDER COLORS ---
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF22304A);

  /// Returns a semantic color used for mastery level badges.
  /// Centralizes the mapping so UI components reuse consistent colors.
  static Color masteryColor(int level) {
    switch (level) {
      case 0:
        return AppColors.error;
      case 1:
        return AppColors.warning;
      case 2:
        return AppColors.info;
      case 3:
        return AppColors.success;
      case 4:
        return AppColors.buttonCyan;
      case 5:
        return AppColors.buttonPurple;
      default:
        return AppColors.textDisabledLight;
    }
  }
}
