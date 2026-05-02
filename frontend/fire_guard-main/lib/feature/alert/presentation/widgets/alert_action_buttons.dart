import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../provider/alert_provider.dart';
import '../../../../core/widgets/spacing_widget.dart';

class AlertActionButtons extends StatelessWidget {
  const AlertActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          text: AppStrings.callEmergency.toUpperCase(),
          type: AppButtonType.white,
          icon: Icons.call,
          onPressed: () {},
        ),
        const VerticalSpace(16),
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: AppStrings.viewLive.toUpperCase(),
                type: AppButtonType.dangerDark,
                icon: Icons.camera_alt_outlined,
                onPressed: () {
                  context.pushNamed(AppRouteConstants.cameras);
                },
              ),
            ),
            const HorizontalSpace(16),
            Expanded(
              child: AppButton(
                text: AppStrings.markSafe.toUpperCase(),
                type: AppButtonType.dangerDark,
                icon: Icons.check_circle_outline,
                onPressed: () {
                  context.pushNamed(AppRouteConstants.home);
                },
              ),
            ),
          ],
        ),
        const VerticalSpace(24),
        TextButton.icon(
          onPressed: () {
            context.read<AlertProvider>().dismissAlarm();
            context.pop();
          },
          icon: Icon(
            Icons.cancel_outlined,
            color: Colors.white70,
            size: 20.sp,
          ),
          label: Text(
            AppStrings.dismissFalseAlarm.toUpperCase(),
            style: AppTextStyles.titleMedium(color: Colors.white70, weight: FontWeight.w700, letterSpacing: 1.0),
          ),
        ),
      ],
    );
  }
}
