import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/spacing_widget.dart';

class AlertInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const AlertInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.input),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white70, size: 20.sp),
          const VerticalSpace(8),
          Text(
            label.toUpperCase(),
            style: AppTextStyles.labelSmall(color: Colors.white70, letterSpacing: 0.5),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const VerticalSpace(4),
          Text(
            value,
            style: AppTextStyles.titleMedium(color: valueColor ?? AppColors.textWhite, weight: FontWeight.w900),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
