import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../provider/alert_provider.dart';
import '../widgets/alert_header.dart';
import '../widgets/alert_feed_video.dart';
import '../widgets/alert_info_row.dart';
import '../widgets/alert_action_buttons.dart';
import '../../../../core/widgets/spacing_widget.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AlertProvider(),
      child: Scaffold(
        backgroundColor: AppColors.danger,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 32.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  AlertHeader(),
                  VerticalSpace(32),
                  AlertFeedVideo(),
                  VerticalSpace(16),
                  AlertInfoRow(),
                  VerticalSpace(16),
                  AlertActionButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
