import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../provider/alert_provider.dart';
import '../../../../core/widgets/spacing_widget.dart';

class AlertFeedVideo extends StatelessWidget {
  const AlertFeedVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AlertProvider>(
      builder: (context, provider, child) {
        final alert = provider.currentAlert;

        return Container(
          height: 240.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 15.r,
                offset: const Offset(0, 8),
              ),
            ],
            gradient: const LinearGradient(
              colors: [AppColors.primaryLight, AppColors.primary],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.star_outline_rounded,
                  color: Colors.white10,
                  size: 80.sp,
                ),
              ),
              if (alert?.isActive ?? false)
                Positioned(
                 top: 16.h,
                 left: 16.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.danger,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: const BoxDecoration(
                            color: AppColors.textWhite,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const HorizontalSpace(4),
                        Text(
                          AppStrings.liveFeed.toUpperCase(),
                          style: AppTextStyles.labelSmall(color: AppColors.textWhite, weight: FontWeight.w900, letterSpacing: 0.5),
                        ),
                      ],
                    ),
                  ),
                ),
              Positioned(
               bottom: 16.h,
               right: 16.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    (alert?.cameraName ?? '').toUpperCase(),
                    style: AppTextStyles.labelSmall(color: AppColors.textWhite, weight: FontWeight.w800, letterSpacing: 1.0),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
