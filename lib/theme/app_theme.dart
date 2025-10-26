import 'package:flutter/material.dart';
import 'package:game_testing/theme/responsive_config.dart';
import 'app_colors.dart';

/// AppTheme: Only 2 palettes (light/dark), 3 button colors, semantic, text, border. Modern deep blue base.
class AppTheme {
  AppTheme._();

  // Standardized opacity levels: only three levels allowed (low, medium, high).
  // Use these with `.withValues(alpha: ...)` for consistent opacity across the app.
  static const double alphaLow = 0.16; // subtle overlays / accents
  static const double alphaMedium =
      0.30; // typical semi-transparent surfaces / borders
  static const double alphaHigh = 0.70; // strong emphasis

  static Color _shiftLightness(Color color, double delta, double alpha) {
    final hsl = HSLColor.fromColor(color);
    final num newLightness = (hsl.lightness + delta).clamp(0.0, 1.0);
    final tinted = hsl.withLightness(newLightness.toDouble()).toColor();
    return tinted.withValues(alpha: alpha);
  }

  static Color _hoverOverlayFor(Color color, {required bool isLightTheme}) {
    final delta = isLightTheme ? 0.10 : 0.18;
    return _shiftLightness(color, delta, alphaLow);
  }

  static Color _pressedOverlayFor(Color color, {required bool isLightTheme}) {
    final delta = isLightTheme ? -0.13 : 0.24;
    return _shiftLightness(color, delta, alphaMedium);
  }

  static ThemeData light(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      // Restore manual ColorScheme to maintain the existing palette
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryLight,
        onPrimary: AppColors
            .textPrimaryLight, // switched to dark for contrast on soft pink primary
        secondary: AppColors.secondaryLight,
        onSecondary: AppColors.textSecondaryLight, // off-white on deeper accent
        surface: AppColors.surfaceLight,
        onSurface: AppColors.textPrimaryLight,
        error: AppColors.error,
        onError: AppColors.textSecondaryLight,
        tertiary: AppColors.buttonPurple,
        onTertiary: AppColors.textSecondaryLight,
        outline: AppColors.borderLight,
      ),
      scaffoldBackgroundColor: AppColors.backgroundLight,
      // cardColor: AppColors.cardLight,
      textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'Nunito',
        bodyColor: AppColors.textPrimaryLight,
        displayColor: AppColors.textPrimaryLight,
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: AppColors.textSecondaryLight,
          fontWeight: FontWeight.bold,
        ),

        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.textPrimaryLight,
        elevation: 0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryLight,
              foregroundColor: AppColors.textSecondaryLight,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: ResponsiveConfig.borderRadius(
                  context,
                  size: RadiusSize.m,
                ),
              ),
              padding: ResponsiveConfig.buttonPadding(
                context,
                size: PaddingSize.m,
              ),
              elevation: 2,
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return _pressedOverlayFor(
                    AppColors.primaryLight,
                    isLightTheme: true,
                  );
                }
                if (states.contains(WidgetState.hovered) ||
                    states.contains(WidgetState.focused)) {
                  return _hoverOverlayFor(
                    AppColors.primaryLight,
                    isLightTheme: true,
                  );
                }
                return null;
              }),
              enableFeedback: false,
            ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style:
            OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryLight,
              side: BorderSide(color: AppColors.primaryLight, width: 2),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: ResponsiveConfig.borderRadius(
                  context,
                  size: RadiusSize.m,
                ),
              ),
              padding: ResponsiveConfig.buttonPadding(
                context,
                size: PaddingSize.m,
              ),
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return _pressedOverlayFor(
                    AppColors.primaryLight,
                    isLightTheme: true,
                  );
                }
                if (states.contains(WidgetState.hovered) ||
                    states.contains(WidgetState.focused)) {
                  return _hoverOverlayFor(
                    AppColors.primaryLight,
                    isLightTheme: true,
                  );
                }
                return null;
              }),
              enableFeedback: false,
            ),
      ),
      textButtonTheme: TextButtonThemeData(
        style:
            TextButton.styleFrom(
              foregroundColor: AppColors.primaryLight,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return _pressedOverlayFor(
                    AppColors.primaryLight,
                    isLightTheme: true,
                  );
                }
                if (states.contains(WidgetState.hovered) ||
                    states.contains(WidgetState.focused)) {
                  return _hoverOverlayFor(
                    AppColors.primaryLight,
                    isLightTheme: true,
                  );
                }
                return null;
              }),
              enableFeedback: false,
            ),
      ),
      listTileTheme: const ListTileThemeData(
        textColor: AppColors.textPrimaryLight,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryLight, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: AppColors.surfaceLight.withValues(alpha: alphaMedium),
        filled: true,
        hintStyle: const TextStyle(color: AppColors.textDisabledLight),
        labelStyle: const TextStyle(color: AppColors.textPrimaryLight),
      ),
      cardTheme: CardThemeData().copyWith(
        color: AppColors.cardLight,
        // color: AppColors.cardLight.withValues(alpha: alphaMedium),
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.secondaryLight.withValues(alpha: alphaMedium),
            width: 1.5,
          ),
          borderRadius: ResponsiveConfig.borderRadius(
            context,
            size: RadiusSize.l,
          ),
        ),
      ),
    );
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      // Restore manual ColorScheme to maintain the existing palette
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryDark,
        onPrimary: AppColors.textPrimaryDark,
        secondary: AppColors.secondaryDark,
        onSecondary: AppColors.textPrimaryDark,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
        error: AppColors.error,
        onError: AppColors.textPrimaryDark,
        tertiary: AppColors.buttonOrange,
        onTertiary: AppColors.textPrimaryDark,
        outline: AppColors.borderDark,
      ),
      textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'Nunito',
        bodyColor: AppColors.textSecondaryLight,
        displayColor: AppColors.textSecondaryLight,
      ),
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: AppBarTheme(
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: AppColors.textSecondaryLight,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryDark,
              foregroundColor: AppColors.textPrimaryDark,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: ResponsiveConfig.borderRadius(
                  context,
                  size: RadiusSize.m,
                ),
              ),
              padding: ResponsiveConfig.buttonPadding(
                context,
                size: PaddingSize.m,
              ),
              elevation: 2,
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return _pressedOverlayFor(
                    AppColors.primaryDark,
                    isLightTheme: false,
                  );
                }
                if (states.contains(WidgetState.hovered) ||
                    states.contains(WidgetState.focused)) {
                  return _hoverOverlayFor(
                    AppColors.primaryDark,
                    isLightTheme: false,
                  );
                }
                return null;
              }),
              enableFeedback: false,
            ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style:
            OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryDark,
              side: const BorderSide(color: AppColors.primaryDark, width: 2),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: ResponsiveConfig.borderRadius(
                  context,
                  size: RadiusSize.m,
                ),
              ),
              padding: ResponsiveConfig.buttonPadding(
                context,
                size: PaddingSize.m,
              ),
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return _pressedOverlayFor(
                    AppColors.primaryDark,
                    isLightTheme: false,
                  );
                }
                if (states.contains(WidgetState.hovered) ||
                    states.contains(WidgetState.focused)) {
                  return _hoverOverlayFor(
                    AppColors.primaryDark,
                    isLightTheme: false,
                  );
                }
                return null;
              }),
              enableFeedback: false,
            ),
      ),
      textButtonTheme: TextButtonThemeData(
        style:
            TextButton.styleFrom(
              foregroundColor: AppColors.primaryDark,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ).copyWith(
              overlayColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) {
                  return _pressedOverlayFor(
                    AppColors.primaryDark,
                    isLightTheme: false,
                  );
                }
                if (states.contains(WidgetState.hovered) ||
                    states.contains(WidgetState.focused)) {
                  return _hoverOverlayFor(
                    AppColors.primaryDark,
                    isLightTheme: false,
                  );
                }
                return null;
              }),
              enableFeedback: false,
            ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryDark, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: AppColors.surfaceDark,
        filled: true,
        labelStyle: const TextStyle(color: AppColors.textSecondaryDark),
        hintStyle: const TextStyle(color: AppColors.textDisabledDark),
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardDark,
        
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.primaryDark.withValues(alpha: alphaHigh),
            width: 1,
          ),
          borderRadius: ResponsiveConfig.borderRadius(
            context,
            size: RadiusSize.l,
          ),
        ),
      ),
    );
  }

  // Context-aware helpers: pick light/dark trio based on Theme.of(context)
  static ButtonStyle cyanButtonOf(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final color = isLight ? AppColors.buttonLightCyan : AppColors.buttonCyan;
    return _coloredButton(context, color);
  }

  static ButtonStyle orangeButtonOf(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final color = isLight
        ? AppColors.buttonLightOrange
        : AppColors.buttonOrange;
    return _coloredButton(context, color);
  }

  static ButtonStyle purpleButtonOf(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final color = isLight
        ? AppColors.buttonLightPurple
        : AppColors.buttonPurple;
    return _coloredButton(context, color);
  }

  static ButtonStyle _coloredButton(BuildContext context, Color color) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    // Determine a readable foreground color by checking luminance.
    final fg = color.computeLuminance() > 0.5
        ? AppColors.textPrimaryLight
        : AppColors.textSecondaryLight;
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: fg,
      textStyle: Theme.of(
        context,
      ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold, color: fg),
      shape: RoundedRectangleBorder(
        borderRadius: ResponsiveConfig.borderRadius(
          context,
          size: RadiusSize.m,
        ),
      ),
      padding: ResponsiveConfig.buttonPadding(context, size: PaddingSize.m),
      elevation: 2,
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return _pressedOverlayFor(color, isLightTheme: isLight);
        }
        if (states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.focused)) {
          return _hoverOverlayFor(color, isLightTheme: isLight);
        }
        return null;
      }),
      enableFeedback: false,
    );
  }

  // --- SEMANTIC COLOR HELPERS ---
  /// Returns appropriate background color for choice feedback
  static Color choiceFeedbackColor(
    bool isCorrect,
    bool isSelected,
    bool showAnswer,
  ) {
    if (showAnswer) {
      if (isSelected) {
        return isCorrect
            ? AppColors.success.withValues(alpha: alphaHigh)
            : AppColors.error.withValues(alpha: alphaHigh);
      } else if (isCorrect) {
        return AppColors.success.withValues(alpha: alphaHigh);
      }
    } else if (isSelected && showAnswer) {
      return isCorrect
          ? AppColors.success.withValues(alpha: alphaHigh)
          : AppColors.error.withValues(alpha: alphaHigh);
    }
    return AppColors.transparent;
  }

  /// Returns theme-appropriate text styles for different contexts
  static TextStyle questionTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface,
        ) ??
        const TextStyle();
  }

  static TextStyle choiceTextStyle(BuildContext context) {
    return Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500) ??
        const TextStyle();
  }

  static TextStyle masteryLevelTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondaryLight,
        ) ??
        const TextStyle();
  }

  /// Returns text style for IPA (International Phonetic Alphabet) text using NotoSans font
  static TextStyle ipaTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFamily: 'NotoSans',
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.italic,
        ) ??
        const TextStyle(fontFamily: 'NotoSans', fontStyle: FontStyle.italic);
  }
}
