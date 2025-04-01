import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Base text styles with size 12
  static const TextStyle s12w400 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Metropolis',
    letterSpacing: -0.12,
  );

  static const TextStyle s12w500 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: 'Metropolis',
    letterSpacing: -0.12,
  );

  // Variations with different colors
  static final TextStyle s12w400hint =
      s12w400.copyWith(color: AppColors.textHint);
  static final TextStyle s12w400black =
      s12w400.copyWith(color: AppColors.textPrimary);
  static final TextStyle s12w500secondary =
      s12w500.copyWith(color: AppColors.textSecondary);
  static final TextStyle s12w500error =
      s12w500.copyWith(color: AppColors.textError);
  static final TextStyle s12w500primary =
      s12w500.copyWith(color: AppColors.primary);

  // Header text styles
  static const TextStyle s15w500 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    fontFamily: 'Metropolis',
    color: AppColors.textPrimary,
  );
}
