import 'package:flutter/material.dart';

/// App-wide color palette (replaced with new palette requested).
class AppColors {
  static const Color transparent = Color(0x00000000);

  // --- PRIMARY BRAND COLORS --- [Maybe used for anything needing a primary accent <maybe>]
  static const Color primaryLight = Color(0xFFE91E63); // Vibrant Pink
  static const Color primaryDark = Color(0xFF2196F3); // Vibrant Blue

  // ==========================================
  // 1. THEME COLOR EXTENSIONS
  // ==========================================

  // --- LIGHT THEME EXTENSIONS ---
  static const Color surfaceLightVariant = Color(0xFFF5F5F7);
  static const Color backgroundLightDimmed = Color(0xFFE0E0E0);
  static const Color primaryLightVariant = Color(0xFF64B5F6);
  static const Color secondaryLightVariant = Color(0xFF00B8D4);

  // --- DARK THEME EXTENSIONS ---
  static const Color surfaceDarkVariant = Color(0xFF1A1F2E);
  static const Color backgroundDarkDimmed = Color(0xFF05070C);
  static const Color primaryDarkVariant = Color(0xFF3EB8F6); //3EB8F6
  static const Color secondaryDarkVariant = Color(0xFF3B83F6);

  // ==========================================
  // 2. TYPOGRAPHY & BORDERS
  // ==========================================

  // --- LIGHT THEME TEXT & BORDERS ---
  /// Deep dark charcoal for main headings and primary body text in light mode
  static const Color textPrimaryLight = Color(0xFF121212);
  /// Medium grey for descriptions, hints, and secondary labels in light mode
  static const Color textSecondaryLight = Color(0xFF757575);
  /// Light silver for subtle dividers and card outlines in light mode
  static const Color borderLight = Color(0xFFE0E0E0);

  // --- DARK THEME TEXT & BORDERS ---
  /// Pure white for maximum contrast on dark backgrounds
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  /// Soft blue-grey to reduce eye strain for secondary details in dark mode
  static const Color textSecondaryDark = Color(0xFF90A4AE);
  /// Deep slate navy to define elements subtly in dark mode
  static const Color borderDark = Color(0xFF2C3444);

  // ==========================================
  // 3. DIFFICULTY LEVEL COLORS
  // ==========================================
  static const Color easyDifficulty = Color(0xFF00E054);
  static const Color mediumDifficulty = Color(0xFFFEB800);
  static const Color hardDifficulty = Color(0xFFB71C1C);

  static const Color easyTintDifficulty = Color(0xFF0E211B);
  static const Color mediumTintDifficulty = Color(0xFF241D12);
  static const Color hardTintDifficulty = Color(0xFF231418);

  // ==========================================
  // 4. ANSWER FEEDBACK COLORS
  // ==========================================
  static const Color correctAnswer = Color(0xFF60E8A6);
  static const Color wrongAnswer = Color(0xFFFF1744);

  // ==========================================
  // 5. SELECT GAME SCREEN COLORS
  // ==========================================
  static const Color gameCardBackground = Color(0xFF121826);
  static const Color gameCardBorder = Color(0xFF2C3444);
  static const Color gameCardHighlight = Color(0xFF3D475C);
  static const Color gameCategoryHeader = Color(0xFF90A4AE);

  // ==========================================
  // 6. UI STATE COLORS
  // ==========================================
  static const Color disabledBackground = Color(0xFFBDBDBD);
  static const Color hoverOverlay = Color(0x26FFFFFF);
  static const Color focusBorder = Color(0xFF2196F3);
  static const Color selectedItemBackground = Color(0x1A2196F3);
  static const Color quitLightButtonBackground = Color(0xFFFF6E68);
  static const Color quitDarkButtonBackground = Color(0xFFFF8957);

  // ==========================================
  // 7. ADDITIONAL SEMANTIC COLORS
  // ==========================================
  static const Color highlight = Color(0xFFFFF176);
  static const Color link = Color(0xFF4FC3F7);
  static const Color placeholder = Color(0xFF757575);

  // ==========================================
  // 8. GAME CATEGORY NEON COLORS
  // ==========================================

  // --- Visual Memory (Blue) ---
  static const Color iconMemory = Color(0xFF00E5FF);
  static const Color iconMemoryBg = Color(0x1A00E5FF); // 10% Opacity

  // --- Flashing Tiles (Amber/Yellow) ---
  static const Color iconTiles = Color(0xFFFFD600);
  static const Color iconTilesBg = Color(0x1AFFD600);

  // --- Quick Maths (Emerald Green) ---
  static const Color iconMath = Color(0xFF00E676);
  static const Color iconMathBg = Color(0x1A00E676);

  // --- Word Ladder (Orange) ---
  static const Color iconWord = Color(0xFFFF9100);
  static const Color iconWordBg = Color(0x1AFF9100);

  // --- Color Match (Purple) ---
  static const Color iconColor = Color(0xFFD500F9);
  static const Color iconColorBg = Color(0x1AD500F9);

  // --- Logic Flow (Coral/Pink) ---
  static const Color iconLogic = Color(0xFFFF4081);
  static const Color iconLogicBg = Color(0x1AFF4081);

  // ==========================================
  // 9. LEADERBOARD RANKING COLORS
  // ==========================================

  // 1st Place
  static const Color firstText = Color(0xFFFFD700);
  static const Color firstBorder = Color(0xFFFFB300);
  static const Color firstTint = Color(0x14FFD700); // 8% Opacity

  // 2nd Place
  static const Color secondText = Color(0xFFE0E0E0);
  static const Color secondBorder = Color(0xFF9E9E9E);
  static const Color secondTint = Color(0x14E0E0E0); // 8% Opacity

  // 3rd Place
  static const Color thirdText = Color(0xFFCD7F32);
  static const Color thirdBorder = Color(0xFFA0522D);
  static const Color thirdTint = Color(0x14CD7F32); // 8% Opacity
}
