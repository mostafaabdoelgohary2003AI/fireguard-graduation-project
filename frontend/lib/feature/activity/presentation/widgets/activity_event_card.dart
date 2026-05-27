import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:fire_gaurd/core/models/activity_model.dart';
import 'package:fire_gaurd/core/services/endpoints.dart';
import 'package:fire_gaurd/core/theme/app_colors.dart';
import 'package:fire_gaurd/core/theme/app_text_style.dart';
import 'package:fire_gaurd/core/widgets/spacing_widget.dart';
import 'package:fire_gaurd/feature/activity/presentation/provider/activity_provider.dart';


/// A single activity/event card used in both the home snippet and the
/// history screen.
class ActivityEventCard extends StatelessWidget {
  final ActivityEvent event;

  const ActivityEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final isPending = event.isPending;
    final Color statusColor = isPending ? AppColors.danger : AppColors.success;
    final Color statusBg =
        isPending ? AppColors.dangerLight : const Color(0xFFDCFCEE);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary.withValues(alpha: 0.08),
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Header bar ────────────────────────────────────────────────────
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: statusBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            ),
            child: Row(
              children: [
                Icon(
                  isPending ? Icons.local_fire_department : Icons.check_circle_outline,
                  color: statusColor,
                  size: 18.sp,
                ),
                const HorizontalSpace(8),
                Text(
                  event.eventTypeLabel.toUpperCase(),
                  style: AppTextStyles.labelSmall(
                    color: statusColor,
                    weight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
                const Spacer(),
                // Status pill
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    event.status.toUpperCase(),
                    style: AppTextStyles.labelSmall(
                      color: Colors.white,
                      weight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Body ─────────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Camera name + zone
                Row(
                  children: [
                    Icon(Icons.videocam_outlined,
                        size: 14.sp, color: AppColors.textSecondary),
                    const HorizontalSpace(6),
                    Expanded(
                      child: Text(
                        event.cameraName,
                        style: AppTextStyles.bodyMedium(
                          color: AppColors.primary,
                          weight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const HorizontalSpace(8),
                    Icon(Icons.location_on_outlined,
                        size: 12.sp, color: AppColors.textSecondary),
                    const HorizontalSpace(4),
                    Text(
                      event.zoneName,
                      style: AppTextStyles.labelSmall(
                          color: AppColors.textSecondary),
                    ),
                  ],
                ),

                if (event.cameraLocation.isNotEmpty) ...[
                  const VerticalSpace(4),
                  Text(
                    event.cameraLocation,
                    style: AppTextStyles.labelSmall(
                        color: AppColors.textSecondary),
                  ),
                ],

                const VerticalSpace(10),
                Divider(height: 1, color: AppColors.input),
                const VerticalSpace(10),

                // AI confidence + time
                Row(
                  children: [
                    // AI confidence
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.psychology_outlined,
                              size: 13.sp, color: AppColors.accent),
                          const HorizontalSpace(4),
                          Text(
                            '${event.aiConfidence.toStringAsFixed(1)}% AI',
                            style: AppTextStyles.labelSmall(
                              color: AppColors.accent,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.access_time_rounded,
                        size: 13.sp, color: AppColors.textSecondary),
                    const HorizontalSpace(4),
                    Text(
                      event.formattedTime,
                      style: AppTextStyles.labelSmall(
                          color: AppColors.textSecondary),
                    ),
                  ],
                ),

                if (event.notes != null && event.notes!.isNotEmpty) ...[
                  const VerticalSpace(8),
                  Text(
                    event.notes!,
                    style: AppTextStyles.labelSmall(
                        color: AppColors.textSecondary),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],

                if (event.isActive) ...[
                  const VerticalSpace(12),
                  SizedBox(
                    width: double.infinity,
                    height: 38.h,
                    child: ElevatedButton.icon(
                      onPressed: () => _showResolveDialog(context),
                      icon: Icon(Icons.check_circle_outline, size: 16.sp, color: Colors.white),
                      label: Text(
                        'RESOLVE ALARM',
                        style: AppTextStyles.labelMedium(
                          color: Colors.white,
                          weight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.danger,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showResolveDialog(BuildContext context) {
    final snapshotUrl = event.snapshot != null
        ? (event.snapshot!.startsWith('http')
            ? event.snapshot!
            : '${Endpoints.baseUrl}${event.snapshot!.startsWith('/') ? event.snapshot!.substring(1) : event.snapshot}')
        : null;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: 320.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Fire Snapshot Image Header
                  if (snapshotUrl != null)
                    Stack(
                      children: [
                        Image.network(
                          snapshotUrl,
                          height: 200.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 200.h,
                              color: AppColors.input,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200.h,
                              color: AppColors.dangerLight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 48.sp,
                                    color: AppColors.danger,
                                  ),
                                  const VerticalSpace(8),
                                  Text(
                                    'Could not load snapshot',
                                    style: AppTextStyles.labelMedium(
                                      color: AppColors.danger,
                                      weight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        // Danger Badge Overlay on Image
                        Positioned(
                          top: 12.h,
                          left: 12.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColors.danger,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.local_fire_department, size: 14.sp, color: Colors.white),
                                const HorizontalSpace(4),
                                Text(
                                  'ACTIVE THREAT',
                                  style: AppTextStyles.labelSmall(
                                    color: Colors.white,
                                    weight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Container(
                      height: 120.h,
                      color: AppColors.dangerLight,
                      child: Center(
                        child: Icon(
                          Icons.local_fire_department_outlined,
                          size: 64.sp,
                          color: AppColors.danger,
                        ),
                      ),
                    ),

                  // Dialog Body Information
                  Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Resolve Fire Incident?',
                          style: AppTextStyles.heading3(
                            color: AppColors.primary,
                          ),
                        ),
                        const VerticalSpace(8),
                        Text(
                          'Are you sure you want to resolve this fire incident? This will clear the active alarm status and mark this event as resolved.',
                          style: AppTextStyles.bodyMedium(
                            color: AppColors.textSecondary,
                            weight: FontWeight.w500,
                        ),
                      ),
                      const VerticalSpace(16),
                      // Details Box
                      Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.input, width: 1.w),
                        ),
                        child: Column(
                          children: [
                            _buildDetailRow(
                              icon: Icons.videocam_outlined,
                              label: 'Camera',
                              value: event.cameraName,
                            ),
                            const VerticalSpace(8),
                            _buildDetailRow(
                              icon: Icons.location_on_outlined,
                              label: 'Zone',
                              value: event.zoneName,
                            ),
                            const VerticalSpace(8),
                            _buildDetailRow(
                              icon: Icons.access_time_rounded,
                              label: 'Detected',
                              value: event.formattedTime,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Actions Section
                Padding(
                  padding: EdgeInsets.only(left: 20.r, right: 20.r, bottom: 20.r),
                  child: Row(
                    children: [
                      // Cancel Button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: AppColors.textSecondary.withValues(alpha: 0.3)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: Text(
                            'CANCEL',
                            style: AppTextStyles.labelMedium(
                              color: AppColors.textSecondary,
                              weight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const HorizontalSpace(12),
                      // Resolve Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(dialogContext).pop();
                            
                            // Call resolve action
                            try {
                              await context.read<ActivityProvider>().resolveEvent(event.id);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(Icons.check_circle_outline, color: Colors.white, size: 20.sp),
                                        const HorizontalSpace(8),
                                        Expanded(
                                          child: Text(
                                            'Activity marked as resolved successfully.',
                                            style: AppTextStyles.labelMedium(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: AppColors.success,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                );
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(Icons.error_outline_rounded, color: Colors.white, size: 20.sp),
                                        const HorizontalSpace(8),
                                        Expanded(
                                          child: Text(
                                            'Failed to resolve activity: $e',
                                            style: AppTextStyles.labelMedium(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    backgroundColor: AppColors.danger,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.danger,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: Text(
                            'CONFIRM',
                            style: AppTextStyles.labelMedium(
                              color: Colors.white,
                              weight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        );
      },
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: AppColors.textSecondary),
        const HorizontalSpace(8),
        Text(
          '$label:',
          style: AppTextStyles.labelSmall(
            color: AppColors.textSecondary,
            weight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles.labelSmall(
            color: AppColors.primary,
            weight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

