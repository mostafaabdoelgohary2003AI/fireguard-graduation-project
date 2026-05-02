import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/constant/app_strings.dart';
import '../../../../../core/constant/app_route_constant.dart';
import '../../../../../core/widgets/spacing_widget.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.alreadyHaveAccount,
          style: AppTextStyles.labelLarge(color: AppColors.textSecondary, weight: FontWeight.w500),
        ),
        const HorizontalSpace(4),
        GestureDetector(
          onTap: () {
            context.goNamed(AppRouteConstants.login);
          },
          child: Text(
            AppStrings.signIn,
            style: AppTextStyles.labelLarge(),
          ),
        ),
      ],
    );
  }
}
