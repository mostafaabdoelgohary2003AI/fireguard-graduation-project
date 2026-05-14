import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/constant/app_route_constant.dart';
import '../provider/home_provider.dart';
import '../../../../core/widgets/spacing_widget.dart';

class SimulateAlertToggle extends StatelessWidget {
  final VoidCallback onSimulate;

  const SimulateAlertToggle({super.key, required this.onSimulate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.toggleSystemState.toUpperCase(),
          style: AppTextStyles.bodyMedium(letterSpacing: 1.0),
        ),
        const VerticalSpace(12),
        GestureDetector(
          onTap: () {
            if (context.mounted) {
              context.pushNamed(AppRouteConstants.alert);
            }
            onSimulate();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.dangerLight,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              AppStrings.simulateAlert.toUpperCase(),
              style: AppTextStyles.titleMedium(color: AppColors.danger, weight: FontWeight.w800, letterSpacing: 0.5),
            ),
          ),
        ),
      ],
    );
  }
}
