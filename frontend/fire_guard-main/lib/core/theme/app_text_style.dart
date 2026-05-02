import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Heading Level 1: Extra large, italicized emphasis headings
  static TextStyle heading1({Color color = AppColors.primary, double? letterSpacing}) => TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        color: color,
        letterSpacing: letterSpacing,
      );

  // Heading Level 2: Standard large bold headings (Titles)
  static TextStyle heading2({Color color = AppColors.primary, double? letterSpacing}) => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w900,
        color: color,
        letterSpacing: letterSpacing,
      );

  // Heading Level 3: Medium bold headings (AppBars, main cards)
  static TextStyle heading3({Color color = AppColors.primary, double? letterSpacing}) => TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w900,
        color: color,
        letterSpacing: letterSpacing,
      );

  // Title Large: Detailed card titles or heavy items
  static TextStyle titleLarge({Color color = AppColors.primary, double? letterSpacing}) => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w900,
        color: color,
        letterSpacing: letterSpacing,
      );

  // Title Medium: Section headers, input text, setting items
  static TextStyle titleMedium({Color color = AppColors.primary, FontWeight weight = FontWeight.w800, double? letterSpacing}) => TextStyle(
        fontSize: 14.sp,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      );

  // Body Large: Readable lists, descriptive items
  static TextStyle bodyLarge({Color color = AppColors.textSecondary, FontWeight weight = FontWeight.w800, double? letterSpacing}) => TextStyle(
        fontSize: 15.sp,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      );

  // Body Medium: Metadata, timestamps, status text
  static TextStyle bodyMedium({Color color = AppColors.textSecondary, FontWeight weight = FontWeight.w700, double? letterSpacing}) => TextStyle(
        fontSize: 12.sp,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      );

  // Label Large: Links, prominent calls to action underneath forms
  static TextStyle labelLarge({Color color = AppColors.accent, FontWeight weight = FontWeight.w800, double? letterSpacing}) => TextStyle(
        fontSize: 13.sp,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      );

  // Label Medium: Tiny functional labels (Input Headers, Section Headers)
  static TextStyle labelMedium({Color color = AppColors.textSecondary, FontWeight weight = FontWeight.w700, double? letterSpacing}) => TextStyle(
        fontSize: 11.sp,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      );

  // Label Small: Badges, version numbers, live pills
  static TextStyle labelSmall({Color color = AppColors.textSecondary, FontWeight weight = FontWeight.w800, double? letterSpacing}) => TextStyle(
        fontSize: 10.sp,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      );
}
