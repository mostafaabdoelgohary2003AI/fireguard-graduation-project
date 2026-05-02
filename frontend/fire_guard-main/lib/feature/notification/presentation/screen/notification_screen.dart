import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../provider/notification_provider.dart';
import '../widgets/notification_tabs.dart';
import '../widgets/notification_card.dart';
import '../../../../core/widgets/spacing_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotificationProvider(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.card,
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primary),
            onPressed: () => context.pop(),
          ),
          title: Text(
            AppStrings.history,
            style: AppTextStyles.heading3(),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.calendar_today_outlined,
                color: AppColors.primary,
                size: 24.sp,
              ),
              onPressed: () {},
            ),
            const HorizontalSpace(8),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const NotificationTabs(),
            const VerticalSpace(4),
            Divider(height: 1.h, color: AppColors.input),
            Expanded(
              child: Consumer<NotificationProvider>(
                builder: (context, provider, child) {
                  final data = provider.filteredData;
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    itemCount: data.length,
                    separatorBuilder: (ctx, index) => const VerticalSpace(12),
                    itemBuilder: (ctx, index) =>
                        NotificationCard(item: data[index]),
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
