import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../provider/notification_provider.dart';

class NotificationTabs extends StatelessWidget {
  const NotificationTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        return Container(
          color: AppColors.card,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: provider.tabs.map((tab) {
                final isSelected = provider.selectedTab == tab;
                return GestureDetector(
                  onTap: () => provider.selectTab(tab),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.input,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      tab,
                      style: AppTextStyles.bodyMedium(
                        color: isSelected ? AppColors.textWhite : AppColors.textSecondary,
                        weight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
