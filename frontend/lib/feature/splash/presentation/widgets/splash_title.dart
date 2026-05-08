import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/widgets/spacing_widget.dart';

class SplashTitle extends StatelessWidget {
  const SplashTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.appName,
          style: AppTextStyles.heading1(letterSpacing: 1.5),
        ),
        const VerticalSpace(8),
        Text(
          AppStrings.loginTitle.toUpperCase(),
          style: AppTextStyles.labelMedium(letterSpacing: 2.0),
        ),
      ],
    );
  }
}
