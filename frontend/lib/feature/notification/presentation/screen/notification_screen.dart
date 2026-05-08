import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/models/event_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../provider/notification_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late HistoryProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = HistoryProvider()..loadHistory();
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.card,
          elevation:       0,
          centerTitle:     false,
          leading: IconButton(
            icon:      const Icon(Icons.arrow_back, color: AppColors.primary),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'Alert History',
            style: AppTextStyles.heading3(),
          ),
          actions: [
            IconButton(
              icon:      const Icon(Icons.refresh, color: AppColors.primary),
              onPressed: () => _provider.loadHistory(),
            ),
          ],
        ),
        body: Column(
          children: [
            _FilterTabs(),
            Expanded(
              child: Consumer<HistoryProvider>(
                builder: (_, provider, __) {
                  if (provider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.primary),
                    );
                  }

                  if (provider.error != null) {
                    return _ErrorState(
                      message:   provider.error!,
                      onRetry:   provider.loadHistory,
                    );
                  }

                  final data = provider.events;
                  if (data.isEmpty) {
                    return const _EmptyState();
                  }

                  return RefreshIndicator(
                    onRefresh: provider.loadHistory,
                    color:     AppColors.primary,
                    child: ListView.separated(
                      padding:   EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      itemCount: data.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder:      (_, i)  => _EventCard(event: data[i]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Filter tabs ──────────────────────────────────────────────────────────────

class _FilterTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (_, provider, __) {
        return Container(
          color: AppColors.card,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: provider.tabs.map((tab) {
                final selected =
                    provider.tabToFilter(tab) == provider.filter;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: GestureDetector(
                    onTap: () => provider.selectTab(tab),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 7.h),
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.primary
                            : AppColors.input,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        tab,
                        style: AppTextStyles.labelSmall(
                          color:  selected ? Colors.white : AppColors.textSecondary,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

// ── Event card ───────────────────────────────────────────────────────────────

class _EventCard extends StatelessWidget {
  final EventModel event;
  const _EventCard({required this.event});

  Color get _statusColor => switch (event.status) {
        'active'      => const Color(0xFFC62828),
        'resolved'    => const Color(0xFF2E7D32),
        'false_alarm' => const Color(0xFFF57C00),
        _             => AppColors.textSecondary,
      };

  String get _statusLabel => switch (event.status) {
        'active'      => 'ACTIVE',
        'resolved'    => 'RESOLVED',
        'false_alarm' => 'FALSE ALARM',
        _             => event.status.toUpperCase(),
      };

  IconData get _typeIcon =>
      event.isFire ? Icons.local_fire_department : Icons.cloud_outlined;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:    EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color:        AppColors.card,
        borderRadius: BorderRadius.circular(14.r),
        border:       Border.all(
            color: _statusColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:    EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color:        _statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(_typeIcon, color: _statusColor, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.displayTitle,
                      style: AppTextStyles.titleMedium(
                        color:  AppColors.textPrimary,
                        weight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      event.cameraName,
                      style: AppTextStyles.labelSmall(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color:        _statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  _statusLabel,
                  style: AppTextStyles.labelSmall(
                    color:       _statusColor,
                    weight:      FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(height: 1, color: AppColors.input),
          SizedBox(height: 10.h),
          Row(
            children: [
              _meta(Icons.location_on_outlined, event.location),
              const Spacer(),
              _meta(Icons.analytics_outlined,
                  event.formattedConfidence),
            ],
          ),
          SizedBox(height: 6.h),
          _meta(Icons.schedule_outlined, event.formattedDate),
        ],
      ),
    );
  }

  Widget _meta(IconData icon, String text) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 13.sp),
          SizedBox(width: 4.w),
          Text(
            text,
            style: AppTextStyles.labelSmall(color: AppColors.textSecondary),
          ),
        ],
      );
}

// ── Empty / Error states ─────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 56.sp, color: AppColors.textSecondary),
            SizedBox(height: 16.h),
            Text(
              'No events yet',
              style: AppTextStyles.bodyMedium(color: AppColors.textSecondary),
            ),
          ],
        ),
      );
}

class _ErrorState extends StatelessWidget {
  final String      message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: EdgeInsets.all(32.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_off,
                  size: 48.sp, color: AppColors.textSecondary),
              SizedBox(height: 16.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium(
                    color: AppColors.textSecondary),
              ),
              SizedBox(height: 24.h),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon:  const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
}
