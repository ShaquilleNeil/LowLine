import 'package:flutter/material.dart';
import 'package:lowline/core/theme/app_colors.dart';

// ThemeData built from design tokens — placeholder values for now.
class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      
      colorScheme: ColorScheme.dark(
        onPrimary: AppColors.primary,
          surfaceContainer: AppColors.surfaceContainer,
      surfaceContainerHigh: AppColors.surfaceContainerHigh,
        surface: AppColors.background,
        onSurface: AppColors.onSurface,
        primary: AppColors.primaryContainer,
        primaryContainer: AppColors.primaryContainer,
        outlineVariant: AppColors.outlineVariant,
        tertiaryContainer: AppColors.tertiaryContainer,
        errorContainer: AppColors.errorContainer,
      ),
    );
  }

  
}
