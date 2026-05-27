import 'package:fire_gaurd/core/theme/app_colors.dart';
import 'package:fire_gaurd/core/theme/app_text_style.dart';
import 'package:fire_gaurd/core/widgets/spacing_widget.dart';
import 'package:fire_gaurd/feature/activity/presentation/provider/activity_provider.dart';
import 'package:fire_gaurd/feature/activity/presentation/widgets/activity_event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecentActivityList extends StatelessWidget {
  const RecentActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ActivityProvider>();
    final recent = provider.recentEvents;
    final isLoading = provider.isLoadingRecent;
    final error = provider.recentError;

    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Failed to load activities.\n$error',
            style: AppTextStyles.bodyMedium(color: AppColors.error),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (recent.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Text(
            'No recent activities.',
            style: AppTextStyles.bodyMedium(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Column(
      children: recent.asMap().entries.map((entry) {
        final isLast = entry.key == recent.length - 1;
        final event = entry.value;

        return Column(
          children: [
            ActivityEventCard(event: event),
            if (!isLast) const VerticalSpace(12),
          ],
        );
      }).toList(),
    );
  }
}
