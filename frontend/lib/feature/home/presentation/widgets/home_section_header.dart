import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/spacing_widget.dart';

class HomeSectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;

  const HomeSectionHeader({
    super.key,
    required this.title,
    this.action,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 4.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: AppColors.textSecondary,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            const HorizontalSpace(8),
            Text(
              title.toUpperCase(),
              style: AppTextStyles.bodyMedium(color: AppColors.textSecondary, weight: FontWeight.w800, letterSpacing: 1.0),
            ),
          ],
        ),
        if (action != null)
          TextButton(
            onPressed: onAction ?? () => context.pushNamed(AppRouteConstants.notification),
            child: Text(
              action!.toUpperCase(),
              style: AppTextStyles.bodyMedium(color: AppColors.accent, weight: FontWeight.w800, letterSpacing: 0.5),
            ),
          ),
      ],
    );
  }
}
