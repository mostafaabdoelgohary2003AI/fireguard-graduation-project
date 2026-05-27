import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fire_gaurd/feature/cameras/presentation/provider/camera_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/widgets/spacing_widget.dart';

class CameraNetworkStats extends StatelessWidget {
  const CameraNetworkStats({super.key});

  @override
  Widget build(BuildContext context) {
    final cameraProvider = context.watch<CameraProvider>();
    final stats = cameraProvider.stats;
    final isLoading = cameraProvider.isLoading && stats == null;

    final totalUnits = isLoading ? "--" : (stats?.totalUnits.toString() ?? "0");
    final onlineNow = isLoading ? "--" : (stats?.onlineNow.toString() ?? "0");
    final offline = isLoading ? "--" : (stats?.offline.toString() ?? "0");

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: InkWell(
              onTap: () => context.pushNamed(AppRouteConstants.cameras),
              borderRadius: BorderRadius.circular(16.r),
              child: _buildStatCard(
                icon: Icons.camera_alt_outlined,
                value: totalUnits,
                label: AppStrings.totalUnits,
              ),
            ),
          ),
          const HorizontalSpace(12),
          Expanded(
            child: _buildStatCard(
              icon: Icons.ssid_chart_rounded,
              iconColor: AppColors.success,
              value: onlineNow,
              label: AppStrings.onlineNow,
            ),
          ),
          const HorizontalSpace(12),
          Expanded(
            child: _buildStatCard(
              icon: Icons.wifi_off_rounded,
              iconColor: AppColors.danger,
              value: offline,
              label: AppStrings.offlineNow,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    Color? iconColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withValues(alpha: 0.15),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor ?? AppColors.textSecondary, size: 24.sp),
          const VerticalSpace(8),
          Text(
            value,
            style: AppTextStyles.heading2(),
            textAlign: TextAlign.center,
          ),
          const VerticalSpace(4),
          Text(
            label.toUpperCase(),
            style: AppTextStyles.bodyMedium(letterSpacing: 0.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
