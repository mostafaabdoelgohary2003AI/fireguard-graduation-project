import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/event_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/spacing_widget.dart';
import '../../../alert/presentation/provider/alert_provider.dart';
import '../provider/home_provider.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/system_status_card.dart';
import '../widgets/home_section_header.dart';
import '../widgets/camera_network_stats.dart';
import '../widgets/recent_activity_list.dart';
import '../widgets/emergency_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _bannerController;
  late Animation<Offset>   _bannerAnimation;
  late HomeProvider        _homeProvider;

  @override
  void initState() {
    super.initState();

    _bannerController = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 400),
    );
    _bannerAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end:   const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _bannerController,
      curve:  Curves.easeOutBack,
    ));

    _homeProvider = HomeProvider();
    _homeProvider.initialize(_onNewAlert);
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _homeProvider.dispose();
    super.dispose();
  }

  // ── Alert trigger ─────────────────────────────────────────────────────────

  void _onNewAlert(EventModel event) {
    if (!mounted) return;

    // Update the global AlertProvider.
    context.read<AlertProvider>().onNewAlert(event);

    // Show the emergency banner briefly, then navigate.
    _bannerController.forward();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _bannerController.reverse();
        context.pushNamed(AppRouteConstants.alert, extra: event);
      }
    });
  }

  // ── Test alert button (for demo) ──────────────────────────────────────────

  void _triggerTestAlert() {
    final testEvent = EventModel(
      id:           0,
      camera:       1,
      zoneName:     'Zone A',
      eventType:    'fire',
      status:       'active',
      aiConfidence: 97.3,
      detectedAt:   DateTime.now(),
    );
    _onNewAlert(testEvent);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _homeProvider,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const HomeAppBar(),
                  _ConnectionStatusBar(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _homeProvider.refresh,
                      color:     AppColors.primary,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical:   16.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SystemStatusCard(),
                            const VerticalSpace(24),
                            const HomeSectionHeader(
                                title: AppStrings.cameraNetwork),
                            const VerticalSpace(12),
                            const CameraNetworkStats(),
                            const VerticalSpace(24),
                            HomeSectionHeader(
                              title:  AppStrings.recentActivity,
                              action: AppStrings.history,
                              onAction: () => context
                                  .pushNamed(AppRouteConstants.notification),
                            ),
                            const VerticalSpace(12),
                            const RecentActivityList(),
                            const VerticalSpace(48),

                            // Demo test-alert button
                            _TestAlertButton(onTap: _triggerTestAlert),
                            const VerticalSpace(24),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.r),
                    child: AppButton(
                      text:      AppStrings.viewLiveCameras,
                      type:      AppButtonType.primary,
                      onPressed: () =>
                          context.pushNamed(AppRouteConstants.cameras),
                    ),
                  ),
                ],
              ),

              // Emergency banner (slides in from top)
              Positioned(
                top:   16.h,
                left:  16.w,
                right: 16.w,
                child: SlideTransition(
                  position: _bannerAnimation,
                  child:    const EmergencyBanner(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Connection status bar ────────────────────────────────────────────────────

class _ConnectionStatusBar extends StatelessWidget {
  const _ConnectionStatusBar();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) {
        final connected = provider.isConnected;
        final color     = connected ? const Color(0xFF2E7D32) : const Color(0xFFC62828);
        final bgColor   = connected
            ? const Color(0xFF2E7D32).withOpacity(0.08)
            : const Color(0xFFC62828).withOpacity(0.08);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width:   double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
          color:   bgColor,
          child: Row(
            children: [
              Container(
                width:  7.w,
                height: 7.h,
                decoration: BoxDecoration(
                  color:  color,
                  shape:  BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                provider.connectionStatus,
                style: AppTextStyles.labelSmall(
                  color:  color,
                  weight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              if (provider.isLoading)
                SizedBox(
                  width:  10.w,
                  height: 10.h,
                  child:  CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color:       color,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ── Test alert button (graduation demo helper) ────────────────────────────────

class _TestAlertButton extends StatelessWidget {
  final VoidCallback onTap;
  const _TestAlertButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:        onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          border:       Border.all(color: AppColors.danger.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(12.r),
          color:        AppColors.danger.withOpacity(0.06),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.science_outlined,
                color: AppColors.danger, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              'SIMULATE ALERT  (Demo)',
              style: AppTextStyles.labelSmall(
                color:       AppColors.danger,
                weight:      FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
