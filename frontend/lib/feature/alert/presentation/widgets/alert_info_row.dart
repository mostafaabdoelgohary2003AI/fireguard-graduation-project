import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constant/app_strings.dart';
import '../provider/alert_provider.dart';
import 'alert_info_card.dart';
import '../../../../core/widgets/spacing_widget.dart';

class AlertInfoRow extends StatelessWidget {
  const AlertInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    final alert = context.watch<AlertProvider>().currentAlert;

    return Row(
      children: [
        Expanded(
          child: AlertInfoCard(
            icon: Icons.location_on_outlined,
            label: AppStrings.location,
            value: alert.location,
          ),
        ),
        const HorizontalSpace(12),
        Expanded(
          child: AlertInfoCard(
            icon: Icons.access_time_rounded,
            label: AppStrings.time,
            value: alert.time,
          ),
        ),
        const HorizontalSpace(12),
        Expanded(
          child: AlertInfoCard(
            icon: Icons.analytics_outlined,
            label: AppStrings.aiConfidence,
            value: "${alert.aiConfidence}%",
            valueColor: AppColors.warning,
          ),
        ),
      ],
    );
  }
}
