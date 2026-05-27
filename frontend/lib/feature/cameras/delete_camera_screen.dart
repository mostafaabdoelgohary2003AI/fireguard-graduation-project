import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:fire_gaurd/core/theme/app_colors.dart';
import 'package:fire_gaurd/core/theme/app_text_style.dart';
import 'package:fire_gaurd/core/widgets/spacing_widget.dart';
import 'package:fire_gaurd/core/models/camera_model.dart';
import 'package:fire_gaurd/feature/cameras/presentation/provider/camera_provider.dart';

/// Screen for deleting cameras with full API integration.
class DeleteCameraScreen extends StatefulWidget {
  const DeleteCameraScreen({super.key});

  @override
  State<DeleteCameraScreen> createState() => _DeleteCameraScreenState();
}

class _DeleteCameraScreenState extends State<DeleteCameraScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CameraProvider>().fetchCameras();
      }
    });
  }

  void _deleteCamera(Camera camera) async {
    if (camera.id == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Delete Camera',
          style: AppTextStyles.titleMedium(
            color: AppColors.primary,
            weight: FontWeight.w800,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${camera.name}"?\nThis action cannot be undone.',
          style: AppTextStyles.bodyMedium(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyMedium(
                color: AppColors.textSecondary,
                weight: FontWeight.w700,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.danger,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Delete',
              style: AppTextStyles.bodyMedium(
                color: Colors.white,
                weight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final provider = context.read<CameraProvider>();
        await provider.deleteCamera(camera.id!);
        
        if (mounted) {
          if (provider.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to delete camera: ${provider.error}'),
                backgroundColor: AppColors.danger,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Camera "${camera.name}" deleted successfully!'),
                backgroundColor: AppColors.success,
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An unexpected error occurred: $e'),
              backgroundColor: AppColors.danger,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CameraProvider>();
    final cameras = provider.cameras;
    final isLoading = provider.isLoading;
    final isDeleting = provider.isDeleting;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.card,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'DELETE CAMERA',
          style: AppTextStyles.titleMedium(
            color: AppColors.primary,
            weight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primary,
            size: 20.sp,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          isLoading && cameras.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : cameras.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20.r),
                              decoration: BoxDecoration(
                                color: AppColors.input,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.videocam_off_outlined,
                                size: 48.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const VerticalSpace(16),
                            Text(
                              'No cameras available',
                              style: AppTextStyles.titleMedium(
                                color: AppColors.primary,
                                weight: FontWeight.w700,
                              ),
                            ),
                            const VerticalSpace(8),
                            Text(
                              'Add a camera to begin monitoring your environment.',
                              style: AppTextStyles.bodyMedium(
                                color: AppColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: provider.fetchCameras,
                      color: AppColors.primary,
                      child: ListView.separated(
                        padding: EdgeInsets.all(16.r),
                        itemCount: cameras.length,
                        separatorBuilder: (_, __) => const VerticalSpace(12),
                        itemBuilder: (context, index) {
                          final camera = cameras[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.textSecondary
                                      .withValues(alpha: 0.06),
                                  blurRadius: 8.r,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              leading: Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLightest,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.videocam_rounded,
                                  color: AppColors.primary,
                                  size: 24.sp,
                                ),
                              ),
                              title: Text(
                                camera.name,
                                style: AppTextStyles.bodyMedium(
                                  color: AppColors.primary,
                                  weight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const VerticalSpace(4),
                                  Text(
                                    'Location: ${camera.location}',
                                    style: AppTextStyles.labelSmall(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    'Zone: ${camera.zone.name}',
                                    style: AppTextStyles.labelSmall(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  color: AppColors.danger,
                                  size: 24.sp,
                                ),
                                onPressed: () => _deleteCamera(camera),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
          if (isDeleting)
            Container(
              color: Colors.black.withValues(alpha: 0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
