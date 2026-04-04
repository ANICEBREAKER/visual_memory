// filepath: lib/core/config/responsive_config.dart
import 'package:flutter/material.dart';

/// Centralized sizing system to eliminate hardcoded numbers.
///
/// Usage examples:
/// - Spacing: `SizedBox(height: ResponsiveConfig.spacing(context, size: SpacingSize.medium))`
/// - Padding: `padding: ResponsiveConfig.padding(context, size: PaddingSize.large)`
/// - Border radius: `borderRadius: ResponsiveConfig.borderRadius(context, size: RadiusSize.medium)`
/// - Icon size: `size: ResponsiveConfig.iconSize(context, size: IconSize.large)`
class ResponsiveConfig {
  const ResponsiveConfig._();

  // Base unit in dp. All sizes derive from this via multipliers and screen scale.
  static const double _baseUnit = 8.0;

  /// Returns a scale factor based on the shortest side of the screen.
  /// Keeps sizes consistent across phones/tablets while avoiding extremes.
  static double _scaleOf(BuildContext context) {
    final shortest = MediaQuery.sizeOf(context).shortestSide;
    if (shortest < 360) return 0.9; // very small phones
    if (shortest < 400) return 1.0; // small phones
    if (shortest < 600) return 1.0; // typical phones
    if (shortest < 840) return 1.15; // small tablets / large phones
    return 1.25; // tablets and larger
  }

  // ---- SPACING ----
  static double spacing(BuildContext context, {SpacingSize size = SpacingSize.m}) {
    final scale = _scaleOf(context);
    return _baseUnit * size.multiplier * scale;
  }

  // ---- EDGE INSETS HELPERS ----
  static EdgeInsets padding(BuildContext context, {PaddingSize size = PaddingSize.m,}) {
    final v = spacing(context, size: size.asSpacing());
    final h = spacing(context, size: size.asSpacing());
    return EdgeInsets.symmetric(vertical: v, horizontal: h);
  }

  static EdgeInsets edgeInsetsSymmetric(
    BuildContext context, {
    SpacingSize horizontal = SpacingSize.m,
    SpacingSize vertical = SpacingSize.m,
  }) {
    return EdgeInsets.symmetric(
      horizontal: spacing(context, size: horizontal),
      vertical: spacing(context, size: vertical),
    );
  }

  static EdgeInsets edgeInsetsOnly(
    BuildContext context, {
    SpacingSize? left,
    SpacingSize? top,
    SpacingSize? right,
    SpacingSize? bottom,
  }) {
    return EdgeInsets.only(
      left: left != null ? spacing(context, size: left) : 0,
      top: top != null ? spacing(context, size: top) : 0,
      right: right != null ? spacing(context, size: right) : 0,
      bottom: bottom != null ? spacing(context, size: bottom) : 0,
    );
  }

  // ---- BORDER RADIUS ----
  static BorderRadius borderRadius(BuildContext context, {RadiusSize size = RadiusSize.m}) {
    final scale = _scaleOf(context);
    return BorderRadius.circular(_baseUnit * size.multiplier * scale);
  }

  // Returns just the numeric radius value for building Radius.circular(...)
  static double cornerRadiusValue(BuildContext context, {RadiusSize size = RadiusSize.m}) {
    final scale = _scaleOf(context);
    return _baseUnit * size.multiplier * scale;
  }

  // ---- ICON SIZE ----
  static double iconSize(BuildContext context, {IconSize size = IconSize.m}) {
    final scale = _scaleOf(context);
    // Icon sizes are slightly larger per step than spacing for visual balance
    return (_baseUnit * 2) * size.multiplier * scale; // base icon ~16dp
  }

  // ---- BUTTON HELPERS ----
  static EdgeInsets buttonPadding(BuildContext context, {PaddingSize size = PaddingSize.m}) {
    // Horizontal is 1.25x of vertical for button ergonomics
    final v = spacing(context, size: size.asSpacing());
    final h = v * 1.25;
    return EdgeInsets.symmetric(horizontal: h, vertical: v);
  }

  // ---- TEXT SIZE ----
  static double textSize(BuildContext context, {TextSize size = TextSize.m}) {
    final scale = _scaleOf(context);
    return (_baseUnit * 2) * size.multiplier * scale;
  }
}

/// Discrete spacing steps built on top of the base unit (8dp).
/// s=8, m=16, l=24, xl=32, etc., multiplied by device scale.
enum SpacingSize { none, xxs, xs, s, m, l, xl, xxl }

extension SpacingSizeX on SpacingSize {
  double get multiplier {
    switch (this) {
      case SpacingSize.none:
        return 0.0;
      case SpacingSize.xxs:
        return 0.25; // 2dp
      case SpacingSize.xs:
        return 0.75; // 6dp
      case SpacingSize.s:
        return 1.0; // 8dp
      case SpacingSize.m:
        return 2.0; // 16dp
      case SpacingSize.l:
        return 3.0; // 24dp
      case SpacingSize.xl:
        return 4.0; // 32dp
      case SpacingSize.xxl:
        return 5.0; // 40dp
    }
  }
}

/// PaddingSize mirrors SpacingSize for semantic clarity.
enum PaddingSize { xxs, xs, s, m, l, xl, xxl }

extension PaddingSizeX on PaddingSize {
  SpacingSize asSpacing() {
    switch (this) {
      case PaddingSize.xxs:
        return SpacingSize.xxs;
      case PaddingSize.xs:
        return SpacingSize.xs;
      case PaddingSize.s:
        return SpacingSize.s;
      case PaddingSize.m:
        return SpacingSize.m;
      case PaddingSize.l:
        return SpacingSize.l;
      case PaddingSize.xl:
        return SpacingSize.xl;
      case PaddingSize.xxl:
        return SpacingSize.xxl;
    }
  }
}

/// Standard corner radius steps.
enum RadiusSize { s, m, l, xl }

extension RadiusSizeX on RadiusSize {
  double get multiplier {
    switch (this) {
      case RadiusSize.s:
        return 1.0; // 8dp
      case RadiusSize.m:
        return 1.5; // 12dp
      case RadiusSize.l:
        return 2.0; // 16dp
      case RadiusSize.xl:
        return 2.5; // 20dp
    }
  }
}

/// Icon size steps; base icon is ~16dp at IconSize.s
/// m ~ 24dp, l ~ 32dp, xl ~ 40dp (before device scaling)
enum IconSize { s, m, l, xl, xxl }

extension IconSizeX on IconSize {
  double get multiplier {
    switch (this) {
      case IconSize.s:
        return 1.0; // ~16
      case IconSize.m:
        return 1.5; // ~24
      case IconSize.l:
        return 2.0; // ~32
      case IconSize.xl:
        return 2.5; // ~40
      case IconSize.xxl:
        return 5.0;
    }
  }
}

enum TextSize { s, m, l, xl, xxl, xxxl }

extension TextSizeX on TextSize {
  double get multiplier {
    switch (this) {
      case TextSize.s:
        return 15.0 / 16.0; // 15
      case TextSize.m:
        return 18.0 / 16.0; // 18
      case TextSize.l:
        return 20.0 / 16.0; // 20
      case TextSize.xl:
        return 25.0 / 16.0; // 25
      case TextSize.xxl:
        return 30.0 / 16.0; // 30
      case TextSize.xxxl:
        return 45.0 / 16.0; // 45
    }
  }
}