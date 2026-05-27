import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../../domain/entities/notification_entity.dart';
import '../../../../core/widgets/spacing_widget.dart';

class NotificationCard extends StatelessWidget {
  final NotificationEntity item;

  const NotificationCard({super.key, required this.item});

  Color _getStatusColor() {
    switch (item.status) {
      case NotificationStatus.active:
        return AppColors.danger;
      case NotificationStatus.resolved:
        return AppColors.success;
      case NotificationStatus.falseAlarm:
        return AppColors.textSecondary;
    }
  }

  // String _getStatusString() {
  //   switch (item.status) {
  //     case NotificationStatus.active:
  //       return AppStrings.active;
  //     case NotificationStatus.resolved:
  //       return AppStrings.resolved;
  //     case NotificationStatus.falseAlarm:
  //       return AppStrings.falseAlarm;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.textSecondary,
                    size: 24.sp,
                  ),
                ),
                Positioned(
                  top: -2.h,
                  left: -2.w,
                  child: Container(
                    width: 14.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.card, width: 2.w),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const HorizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.date.toUpperCase(),
                      style: AppTextStyles.bodyMedium(
                        color: AppColors.textSecondary,
                        weight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const VerticalSpace(4),
                Text(item.title, style: AppTextStyles.titleLarge()),
                const VerticalSpace(6),
                Row(
                  children: [
                    Icon(
                      Icons.analytics_outlined,
                      color: AppColors.accent,
                      size: 14.sp,
                    ),
                    const HorizontalSpace(4),
                    Text(item.confidence, style: AppTextStyles.bodyMedium()),
                    const HorizontalSpace(12),
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.textSecondary,
                      size: 14.sp,
                    ),
                    const HorizontalSpace(4),
                    Text(
                      "${AppStrings.zone} ${item.zone}",
                      style: AppTextStyles.bodyMedium(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const HorizontalSpace(8),
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Icon(
              Icons.chevron_right_rounded,
              color: AppColors.input,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
