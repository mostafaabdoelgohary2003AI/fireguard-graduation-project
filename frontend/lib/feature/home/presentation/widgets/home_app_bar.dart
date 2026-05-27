import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/widgets/spacing_widget.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.ssid_chart_rounded,
              color: AppColors.textWhite,
              size: 20.sp,
            ),
          ),
          const HorizontalSpace(12),
          Text(
            AppStrings.appName,
            style: AppTextStyles.heading3(),
          ),
          const Spacer(),
          InkWell(
            onTap: () => context.pushNamed(AppRouteConstants.settings),
            child: Icon(
              Icons.settings_outlined,
              color: AppColors.primary,
              size: 24.sp,
            ),
          ),
        ],
      ),
    );
  }
}
