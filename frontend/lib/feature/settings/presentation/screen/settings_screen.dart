import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant/app_route_constant.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/spacing_widget.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/add_camera_button.dart';
import '../../../auth/provider/auth_provider.dart';
import '../widgets/settings_section_title.dart';
import '../widgets/settings_item_tile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        title: Text("Settings", style: AppTextStyles.heading3()),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SettingsSectionTitle(title: "Camera Management"),
            const VerticalSpace(16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  const BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Manage your camera setup',
                    style: AppTextStyles.bodyLarge(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const VerticalSpace(18),
                  SizedBox(
                    width: double.infinity,
                    child: const AddCameraButton(),
                  ),
                ],
              ),
            ),
            const VerticalSpace(24),
            const SettingsSectionTitle(title: "SYSTEM"),
            const VerticalSpace(12),
            Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  SettingsItemTile(
                    title: "Notification Settings",
                    icon: Icons.notifications_none_rounded,
                    iconColor: AppColors.warning,
                    iconBgColor: AppColors.warningLight,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const VerticalSpace(32),
            const SettingsSectionTitle(title: "PROFILE"),
            const VerticalSpace(12),
            Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  SettingsItemTile(
                    title: "Account",
                    icon: Icons.person_outline_rounded,
                    iconColor: AppColors.textSecondary,
                    iconBgColor: AppColors.input,
                    onTap: () => context.pushNamed(AppRouteConstants.profile),
                  ),
                ],
              ),
            ),
            const VerticalSpace(48),
            AppButton(
              text: "Logout",
              icon: Icons.logout_rounded,
              type: AppButtonType.dangerOutline,
              onPressed: () async {
                // Execute logout via AuthProvider
                await context.read<AuthProvider>().logout();
                
                // Navigate to Login screen and clear stack
                if (context.mounted) {
                  context.goNamed(AppRouteConstants.login);
                }
              },
            ),
            const VerticalSpace(24),
            Center(
              child: Text(
                "FIREGUARD V1.0.4",
                style: AppTextStyles.labelSmall(
                  color: AppColors.textSecondary,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
