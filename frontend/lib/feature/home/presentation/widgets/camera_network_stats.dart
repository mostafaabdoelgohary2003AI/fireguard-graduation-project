import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/widgets/spacing_widget.dart';

class CameraNetworkStats extends StatelessWidget {
  const CameraNetworkStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => context.pushNamed(AppRouteConstants.cameras),
            child: _buildStatCard(
              icon: Icons.camera_alt_outlined,
              value: "12",
              label: AppStrings.totalUnits,
            ),
          ),
        ),
        const HorizontalSpace(16),
        Expanded(
          child: _buildStatCard(
            icon: Icons.ssid_chart_rounded,
            iconColor: AppColors.success,
            value: "11",
            label: AppStrings.onlineNow,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    Color? iconColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary,
            blurRadius: 5.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor ?? AppColors.textSecondary, size: 24.sp),
          const VerticalSpace(8),
          Text(
            value,
            style: AppTextStyles.heading2(),
          ),
          const VerticalSpace(4),
          Text(
            label.toUpperCase(),
            style: AppTextStyles.bodyMedium(letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }
}
