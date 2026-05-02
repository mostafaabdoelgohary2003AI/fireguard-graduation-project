import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/widgets/spacing_widget.dart';

class AlertHeader extends StatelessWidget {
  const AlertHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: AppColors.card,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.danger, width: 2.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10.r,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.warning_amber_rounded,
            color: AppColors.danger,
            size: 32.sp,
          ),
        ),
        const VerticalSpace(16),
        Text(
          AppStrings.fireDetected.toUpperCase(),
          style: AppTextStyles.heading1(color: AppColors.textWhite, letterSpacing: 1.5),
          textAlign: TextAlign.center,
        ),
        const VerticalSpace(4),
        Text(
          AppStrings.emergencySystem.toUpperCase(),
          style: AppTextStyles.titleMedium(color: Colors.white70, weight: FontWeight.w800, letterSpacing: 2.0),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
