import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constant/app_strings.dart';
import '../provider/camera_provider.dart';
import '../widgets/camera_card.dart';

class CamerasScreen extends StatefulWidget {
  const CamerasScreen({super.key});

  @override
  State<CamerasScreen> createState() => _CamerasScreenState();
}

class _CamerasScreenState extends State<CamerasScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CameraProvider>().fetchCameras();
    });
  }

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
          title: Text(
            AppStrings.cameras,
            style: AppTextStyles.heading3(letterSpacing: 0.5),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.primary),
              onPressed: () {},
            ),
          ],
        ),
        body: Consumer<CameraProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.cameras.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.error != null && provider.cameras.isEmpty) {
              return Center(child: Text(provider.error!));
            }

            return Column(
              children: [
                Expanded(
                  child: provider.cameras.isEmpty
                      ? const Center(child: Text('No cameras found'))
                      : GridView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                          itemCount: provider.cameras.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.w,
                                mainAxisSpacing: 16.h,
                                childAspectRatio: 0.9,
                              ),
                          itemBuilder: (context, index) {
                            return CameraCard(camera: provider.cameras[index]);
                          },
                        ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: Text(
                    "${provider.activeCameras} / ${provider.totalCameras} ACTIVE",
                    style: AppTextStyles.titleMedium(color: AppColors.textSecondary, weight: FontWeight.w800, letterSpacing: 1.5),
                  ),
                ),
              ],
            );
          },
        ),
      );
  }
}
