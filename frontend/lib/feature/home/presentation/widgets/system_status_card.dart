import 'package:fire_gaurd/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../provider/home_provider.dart';
import '../../../../core/widgets/spacing_widget.dart';
import 'package:fire_gaurd/feature/activity/presentation/provider/activity_provider.dart';

class SystemStatusCard extends StatelessWidget {
  const SystemStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final activityProvider = context.watch<ActivityProvider>();
    final isSystemAlert = homeProvider.isSystemAlert || activityProvider.hasActiveActivities;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: isSystemAlert ? AppColors.danger : AppColors.success,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: (isSystemAlert ? AppColors.danger : AppColors.success),
            blurRadius: 20.r,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: const BoxDecoration(
              color: AppColors.textWhite,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isSystemAlert
                  ? Icons.warning_amber_rounded
                  : Icons.verified_user_outlined,
              color: isSystemAlert ? AppColors.danger : AppColors.success,
              size: 32.sp,
            ),
          ),
          const VerticalSpace(16),
          Text(
            AppStrings.currentStatus.toUpperCase(),
            style: AppTextStyles.titleMedium(color: AppColors.textWhite, weight: FontWeight.w700, letterSpacing: 1.5),
          ),
          const VerticalSpace(4),
          Text(
            isSystemAlert
                ? AppStrings.systemNotSecure.toUpperCase()
                : AppStrings.systemSecure.toUpperCase(),
            style: AppTextStyles.heading2(color: AppColors.textWhite, letterSpacing: 1.0),
          ),
          if (isSystemAlert) ...[
            const VerticalSpace(16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.textWhite,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Text(
                "EMERGENCY ACTION REQUIRED",
                style: AppTextStyles.labelLarge(color: AppColors.danger, weight: FontWeight.w900),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
