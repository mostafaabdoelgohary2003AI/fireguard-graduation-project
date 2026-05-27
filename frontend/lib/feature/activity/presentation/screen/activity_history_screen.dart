import 'package:fire_gaurd/core/theme/app_colors.dart';
import 'package:fire_gaurd/core/theme/app_text_style.dart';
import 'package:fire_gaurd/core/widgets/spacing_widget.dart';
import 'package:fire_gaurd/feature/activity/presentation/provider/activity_provider.dart';
import 'package:fire_gaurd/feature/activity/presentation/widgets/activity_event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ActivityHistoryScreen extends StatefulWidget {
  const ActivityHistoryScreen({super.key});

  @override
  State<ActivityHistoryScreen> createState() => _ActivityHistoryScreenState();
}

class _ActivityHistoryScreenState extends State<ActivityHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ActivityProvider>().fetchAllEvents();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ActivityProvider>();
    final events = provider.filteredEvents;
    final isLoading = provider.isLoadingAll;
    final error = provider.allError;
    final activeFilter = provider.filter;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ACTIVITY HISTORY',
          style: AppTextStyles.titleMedium(
            color: AppColors.primary,
            weight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: AppColors.primary, size: 20.sp),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // ── Filter Section ────────────────────────────────────────────────
          Container(
            color: AppColors.card,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFilterChip(
                  label: 'All',
                  filter: ActivityFilter.all,
                  activeFilter: activeFilter,
                  provider: provider,
                ),
                _buildFilterChip(
                  label: 'Active',
                  filter: ActivityFilter.active,
                  activeFilter: activeFilter,
                  provider: provider,
                ),
                _buildFilterChip(
                  label: 'Resolved',
                  filter: ActivityFilter.resolved,
                  activeFilter: activeFilter,
                  provider: provider,
                ),
              ],
            ),
          ),

          // ── Event List Section ───────────────────────────────────────────
          Expanded(
            child: RefreshIndicator(
              onRefresh: provider.fetchAllEvents,
              color: AppColors.primary,
              child: _buildContent(isLoading, error, events),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required ActivityFilter filter,
    required ActivityFilter activeFilter,
    required ActivityProvider provider,
  }) {
    final isSelected = filter == activeFilter;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => provider.setFilter(filter),
      selectedColor: AppColors.primary,
      backgroundColor: AppColors.input,
      labelStyle: AppTextStyles.bodyMedium(
        color: isSelected ? Colors.white : AppColors.textSecondary,
        weight: isSelected ? FontWeight.w700 : FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      elevation: 0,
      pressElevation: 0,
    );
  }

  Widget _buildContent(
      bool isLoading, String? error, List<dynamic> events) {
    if (isLoading && events.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null && events.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Center(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                children: [
                  Icon(Icons.error_outline_rounded,
                      size: 48.sp, color: AppColors.error),
                  const VerticalSpace(16),
                  Text(
                    'Failed to load activities',
                    style: AppTextStyles.titleMedium(
                        color: AppColors.primary, weight: FontWeight.w700),
                  ),
                  const VerticalSpace(8),
                  Text(
                    error,
                    style: AppTextStyles.bodyMedium(
                        color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    if (events.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Center(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: AppColors.input,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications_off_outlined,
                      size: 40.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const VerticalSpace(16),
                  Text(
                    'No activities found',
                    style: AppTextStyles.titleMedium(
                      color: AppColors.primary,
                      weight: FontWeight.w700,
                    ),
                  ),
                  const VerticalSpace(8),
                  Text(
                    'There are currently no activities matching the selected filter.',
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return ListView.separated(
      padding: EdgeInsets.all(16.r),
      itemCount: events.length,
      separatorBuilder: (_, __) => const VerticalSpace(12),
      itemBuilder: (context, index) {
        return ActivityEventCard(event: events[index]);
      },
    );
  }
}
