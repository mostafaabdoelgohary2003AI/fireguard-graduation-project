import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fire_gaurd/feature/cameras/presentation/provider/camera_provider.dart';
import 'package:fire_gaurd/feature/activity/presentation/provider/activity_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/system_status_card.dart';
import '../widgets/home_section_header.dart';
import '../widgets/camera_network_stats.dart';
import '../widgets/recent_activity_list.dart';
import '../widgets/simulate_alert_toggle.dart';
import '../widgets/emergency_banner.dart';
import '../../../../core/widgets/spacing_widget.dart';
import '../../../../core/services/firebase_notifications.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _bannerAnimationController;
  late Animation<Offset> _bannerAnimation;
  StreamSubscription? _notificationSubscription;

  @override
  void initState() {
    super.initState();
    _bannerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _bannerAnimation =
        Tween<Offset>(
          begin: const Offset(0, -1.5),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _bannerAnimationController,
            curve: Curves.easeOutBack,
          ),
        );

    // Listen for real-time fire alerts while the app is open
    _notificationSubscription = FirebaseNotifications.notificationStream.listen((alert) {
      if (alert.type == 'fire_alert') {
        _triggerAnimation();
        // Reload recent events to update active activities state immediately
        if (mounted) {
          context.read<ActivityProvider>().fetchRecentEvents();
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CameraProvider>().fetchCameraStats();
        context.read<ActivityProvider>().fetchRecentEvents();
      }
    });
  }

  @override
  void dispose() {
    _bannerAnimationController.dispose();
    _notificationSubscription?.cancel();
    super.dispose();
  }

  void _triggerAnimation() {
    _bannerAnimationController.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _bannerAnimationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const HomeAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SystemStatusCard(),
                        const VerticalSpace(24),
                        const HomeSectionHeader(
                          title: AppStrings.cameraNetwork,
                        ),
                        const VerticalSpace(12),
                        const CameraNetworkStats(),
                        const VerticalSpace(24),
                        const HomeSectionHeader(
                          title: AppStrings.recentActivity,
                          action: AppStrings.history,
                        ),
                        const VerticalSpace(12),
                        const RecentActivityList(),
                        const VerticalSpace(48),
                        SimulateAlertToggle(onSimulate: _triggerAnimation),
                        const VerticalSpace(24),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    children: [
                      AppButton(
                        text: AppStrings.viewLiveCameras,
                        type: AppButtonType.primary,
                        onPressed: () {
                          context.pushNamed(AppRouteConstants.cameras);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Positioned(
              top: 16.h,
              left: 16.w,
              right: 16.w,
              child: SlideTransition(
                position: _bannerAnimation,
                child: const EmergencyBanner(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
