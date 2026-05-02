import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../provider/home_provider.dart';
import '../../../../core/widgets/spacing_widget.dart';

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = context.watch<HomeProvider>().recentActivities;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary,
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: activities.asMap().entries.map((entry) {
          final isLast = entry.key == activities.length - 1;
          final activity = entry.value;

          return Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.history_rounded,
                      color: AppColors.textSecondary,
                      size: 20.sp,
                    ),
                  ),
                  const HorizontalSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.title.toUpperCase(),
                          style: AppTextStyles.labelSmall(color: AppColors.textSecondary, weight: FontWeight.w700, letterSpacing: 0.5),
                        ),
                        const VerticalSpace(2),
                        Text(
                          activity.value,
                          style: AppTextStyles.titleMedium(color: AppColors.primary, weight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  if (activity.trailing != null)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        activity.trailing!.toUpperCase(),
                        style: AppTextStyles.labelSmall(),
                      ),
                    ),
                ],
              ),
              if (!isLast) Divider(height: 16.h, color: AppColors.input),
            ],
          );
        }).toList(),
      ),
    );
  }
}
