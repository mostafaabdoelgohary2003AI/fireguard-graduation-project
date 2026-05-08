import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/event_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/spacing_widget.dart';
import '../provider/alert_provider.dart';

/// Full-screen emergency alert — shown whenever the system detects fire/smoke.
///
/// Receives the triggering [EventModel] via GoRouter's [extra] parameter.
/// Usage:
///   context.pushNamed(AppRouteConstants.alert, extra: event);
class AlertScreen extends StatefulWidget {
  final EventModel? event;
  const AlertScreen({super.key, this.event});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _iconController;
  late Animation<double>   _pulseAnimation;
  late Animation<double>   _iconAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _iconController = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _iconAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.easeInOut),
    );

    // Make sure AlertProvider has the event.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.event != null) {
        context.read<AlertProvider>().onNewAlert(widget.event!);
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _iconController.dispose();
    super.dispose();
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  Color get _bgColor =>
      widget.event?.isSmoke ? const Color(0xFF1A1A2E) : const Color(0xFF8B0000);

  Color get _bgColorLight =>
      widget.event?.isSmoke ? const Color(0xFF16213E) : const Color(0xFFB71C1C);

  IconData get _alertIcon =>
      widget.event?.isSmoke ? Icons.cloud_outlined : Icons.local_fire_department;

  String get _alertTitle =>
      widget.event?.displayTitle ?? 'FIRE DETECTED';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AlertProvider>();
    final event    = provider.currentAlert ?? widget.event;

    return PopScope(
      canPop: false, // prevent back-swipe during active alarm
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (_, __) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end:   Alignment.bottomRight,
                colors: [
                  Color.lerp(_bgColor, _bgColorLight, _pulseAnimation.value)!,
                  _bgColor,
                ],
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildHeader(),
                      VerticalSpace(32.h),
                      _buildWarningIcon(),
                      VerticalSpace(8.h),
                      _buildTitle(),
                      VerticalSpace(32.h),
                      if (event != null) _buildInfoCard(event),
                      VerticalSpace(40.h),
                      _buildActionButtons(provider),
                      VerticalSpace(24.h),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Sections ──────────────────────────────────────────────────────────────

  Widget _buildHeader() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Blinking LIVE indicator
          AnimatedBuilder(
            animation: _iconAnimation,
            builder: (_, __) => Opacity(
              opacity: _iconAnimation.value,
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color:        Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: Colors.white30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width:  8.w,
                      height: 8.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'LIVE',
                      style: AppTextStyles.labelSmall(
                        color:  Colors.white,
                        weight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            'FIREGUARD',
            style: AppTextStyles.labelSmall(
              color:       Colors.white54,
              weight:      FontWeight.w800,
              letterSpacing: 2.0,
            ),
          ),
        ],
      );

  Widget _buildWarningIcon() => AnimatedBuilder(
        animation: _iconAnimation,
        builder: (_, __) => Transform.scale(
          scale: 0.9 + (_iconAnimation.value * 0.1),
          child: Icon(
            _alertIcon,
            size:  100.sp,
            color: Colors.white,
          ),
        ),
      );

  Widget _buildTitle() => Column(
        children: [
          Text(
            '⚠ $_alertTitle',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:      28.sp,
              fontWeight:    FontWeight.w900,
              color:         Colors.white,
              letterSpacing: 1.5,
              shadows: const [
                Shadow(
                  color:  Colors.black45,
                  offset: Offset(0, 2),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'IMMEDIATE ACTION REQUIRED',
            textAlign: TextAlign.center,
            style: AppTextStyles.labelSmall(
              color:       Colors.white60,
              weight:      FontWeight.w700,
              letterSpacing: 2.5,
            ),
          ),
        ],
      );

  Widget _buildInfoCard(EventModel event) => Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color:        Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16.r),
          border:       Border.all(color: Colors.white24),
        ),
        child: Column(
          children: [
            _infoRow(Icons.location_on_outlined,
                'LOCATION', event.location),
            Divider(height: 20.h, color: Colors.white24),
            _infoRow(Icons.videocam_outlined,
                'CAMERA', event.cameraName),
            Divider(height: 20.h, color: Colors.white24),
            _infoRow(Icons.schedule_outlined,
                'DETECTED', event.formattedDate),
            Divider(height: 20.h, color: Colors.white24),
            _infoRow(Icons.analytics_outlined,
                'AI CONFIDENCE', event.formattedConfidence),
            if (event.zoneName.isNotEmpty) ...[
              Divider(height: 20.h, color: Colors.white24),
              _infoRow(Icons.map_outlined, 'ZONE', event.zoneName),
            ],
          ],
        ),
      );

  Widget _infoRow(IconData icon, String label, String value) => Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20.sp),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.labelSmall(
                  color:       Colors.white54,
                  weight:      FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: AppTextStyles.bodyMedium(
                  color:  Colors.white,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      );

  Widget _buildActionButtons(AlertProvider provider) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // STOP ALARM — primary action
          _AlertButton(
            label:    'STOP ALARM',
            icon:     Icons.volume_off_rounded,
            color:    Colors.white,
            textColor: _bgColor,
            isLoading: false,
            onPressed: () async {
              await provider.stopAlarm();
            },
          ),

          SizedBox(height: 12.h),

          // RESOLVE EVENT
          _AlertButton(
            label:    'MARK AS RESOLVED',
            icon:     Icons.check_circle_outline,
            color:    Colors.white24,
            textColor: Colors.white,
            isLoading: provider.isLoading,
            onPressed: provider.isLoading
                ? null
                : () async {
                    final ok = await provider.resolveEvent();
                    if (ok && mounted) context.pop();
                  },
          ),

          SizedBox(height: 12.h),

          // FALSE ALARM
          _AlertButton(
            label:    'FALSE ALARM',
            icon:     Icons.cancel_outlined,
            color:    Colors.white12,
            textColor: Colors.white70,
            isLoading: false,
            onPressed: provider.isLoading
                ? null
                : () async {
                    final ok = await provider.markFalseAlarm();
                    if (ok && mounted) context.pop();
                  },
          ),

          // Error feedback
          if (provider.error != null) ...[
            SizedBox(height: 12.h),
            Text(
              provider.error!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 13.sp),
            ),
          ],
        ],
      );
}

// ── Reusable button for the alert screen ────────────────────────────────────

class _AlertButton extends StatelessWidget {
  final String   label;
  final IconData icon;
  final Color    color;
  final Color    textColor;
  final bool     isLoading;
  final VoidCallback? onPressed;

  const _AlertButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.isLoading,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color:        color,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap:        onPressed,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          alignment: Alignment.center,
          child: isLoading
              ? SizedBox(
                  height: 20.h,
                  width:  20.h,
                  child: CircularProgressIndicator(
                      color: textColor, strokeWidth: 2),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: textColor, size: 20.sp),
                    SizedBox(width: 10.w),
                    Text(
                      label,
                      style: TextStyle(
                        color:      textColor,
                        fontSize:   14.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
