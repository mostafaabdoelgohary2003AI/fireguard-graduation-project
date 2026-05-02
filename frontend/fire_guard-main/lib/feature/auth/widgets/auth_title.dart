import 'package:flutter/material.dart';
import '../../../core/theme/app_text_style.dart';
import '../../../core/constant/app_strings.dart';
import '../../../core/widgets/spacing_widget.dart';

class AuthTitle extends StatelessWidget {
  final String title;

  const AuthTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.appName,
          style: AppTextStyles.heading2(letterSpacing: 1.2),
        ),
        const VerticalSpace(6),
        Text(
          title.toUpperCase(),
          style: AppTextStyles.labelMedium(letterSpacing: 1.5),
        ),
      ],
    );
  }
}
