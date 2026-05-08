import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';
import 'spacing_widget.dart';

enum AppButtonType {
  primary,
  danger,
  dangerDark,
  outline,
  white,
  dangerOutline,
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final IconData? icon;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
        child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width:  20.h,
                child:  CircularProgressIndicator(
                  strokeWidth: 2,
                  color:       _getTextColor(),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20.sp),
                    const HorizontalSpace(8),
                  ],
                  Text(text,
                      style: AppTextStyles.titleLarge(color: _getTextColor())),
                ],
              ),
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    Color backgroundColor;
    Color borderColor = Colors.transparent;
    double elevation = 2;

    switch (type) {
      case AppButtonType.danger:
        backgroundColor = AppColors.danger;
        break;
      case AppButtonType.dangerDark:
        backgroundColor = AppColors.dangerDark;
        break;
      case AppButtonType.outline:
        backgroundColor = Colors.transparent;
        borderColor = AppColors.primary;
        elevation = 0;
        break;
      case AppButtonType.white:
        backgroundColor = AppColors.card;
        elevation = 0;
        break;
      case AppButtonType.dangerOutline:
        backgroundColor = Colors.transparent;
        borderColor = AppColors.dangerLight;
        elevation = 0;
        break;
      case AppButtonType.primary:
        backgroundColor = AppColors.primary;
        break;
    }

    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: _getTextColor(),
      shadowColor: const Color(0x1F000000),
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: borderColor, width: 2.w),
      ),
    );
  }

  Color _getTextColor() {
    if (type == AppButtonType.outline) {
      return AppColors.textWhite;
    } else if (type == AppButtonType.white) {
      return AppColors.danger;
    } else if (type == AppButtonType.dangerOutline) {
      return AppColors.danger;
    }
    return AppColors.textWhite;
  }
}
