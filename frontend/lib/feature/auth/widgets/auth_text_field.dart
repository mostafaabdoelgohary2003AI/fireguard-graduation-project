import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';
import '../provider/auth_provider.dart';
import '../../../core/widgets/spacing_widget.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData prefixIcon;
  final String? hintText;
  final bool isPassword;
  final bool isConfirmPassword;

  const AuthTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.prefixIcon,
    this.hintText,
    this.isPassword = false,
    this.isConfirmPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    final obscure = isConfirmPassword
        ? provider.obscureConfirmPassword
        : provider.obscurePassword;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: AppTextStyles.labelMedium(letterSpacing: 0.5),
        ),
        const VerticalSpace(8),
        TextField(
          controller: controller,
          obscureText: isPassword && obscure,
          style: AppTextStyles.titleMedium(color: AppColors.primary, weight: FontWeight.w600),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.card,
            hintText: hintText,
            hintStyle: AppTextStyles.titleMedium(color: AppColors.textSecondary, weight: FontWeight.w400),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.input, width: 1.w),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.input, width: 1.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 2.w,
              ),
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.textSecondary,
                      size: 20.sp,
                    ),
                    onPressed: () {
                      if (isConfirmPassword) {
                        provider.toggleConfirmPasswordVisibility();
                      } else {
                        provider.togglePasswordVisibility();
                      }
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
