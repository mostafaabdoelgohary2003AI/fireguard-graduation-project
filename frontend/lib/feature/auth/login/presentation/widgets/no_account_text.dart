import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/constant/app_strings.dart';
import '../../../../../core/widgets/spacing_widget.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.noAccount,
          style: AppTextStyles.labelLarge(color: AppColors.textSecondary, weight: FontWeight.w500),
        ),
        const HorizontalSpace(4),
        GestureDetector(
          onTap: () {
            context.goNamed(AppRouteConstants.singup);
          },
          child: Text(
            AppStrings.requestAccess,
            style: AppTextStyles.labelLarge(),
          ),
        ),
      ],
    );
  }
}
