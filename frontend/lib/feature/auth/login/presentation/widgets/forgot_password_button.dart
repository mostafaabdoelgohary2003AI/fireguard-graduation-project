import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/constant/app_strings.dart';
import '../../../../../core/constant/app_route_constant.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // DEBUG: Print when button is clicked
          debugPrint('ForgotPasswordButton: onPressed triggered');
          // Navigate to ForgotPasswordScreen using GoRouter
          context.goNamed(AppRouteConstants.forgotPassword);
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          AppStrings.forgotPassword.toUpperCase(),
          style: AppTextStyles.bodyMedium(color: AppColors.accent),
        ),
      ),
    );
  }
}
