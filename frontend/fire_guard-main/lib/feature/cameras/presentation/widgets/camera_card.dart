import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../../domain/entities/camera_entity.dart';
import '../../../../core/widgets/spacing_widget.dart';

class CameraCard extends StatelessWidget {
  final CameraEntity camera;

  const CameraCard({super.key, required this.camera});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.textSecondary,
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                gradient: const LinearGradient(
                  colors: [AppColors.primaryLight, AppColors.primary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.videocam_outlined,
                      color: Colors.white24,
                      size: 48.sp,
                    ),
                  ),
                  Positioned(
                   top: 8.h,
                   right: 8.w,
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Icon(
                        Icons.open_in_full_rounded,
                        color: AppColors.textWhite,
                        size: 16.sp,
                      ),
                    ),
                  ),
                  if (camera.isLive)
                    Positioned(
                     bottom: 8.h,
                     left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6.w,
                              height: 6.h,
                              decoration: const BoxDecoration(
                                color: AppColors.success,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const HorizontalSpace(4),
                            Text(
                              AppStrings.live,
                              style: AppTextStyles.labelSmall(color: AppColors.textWhite, weight: FontWeight.w900, letterSpacing: 0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    camera.title,
                    style: AppTextStyles.bodyMedium(color: AppColors.primary, weight: FontWeight.w800),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: camera.isLive
                        ? AppColors.success
                        : AppColors.textSecondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
