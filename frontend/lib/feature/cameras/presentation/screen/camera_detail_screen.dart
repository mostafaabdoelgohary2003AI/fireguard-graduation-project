import 'package:fire_gaurd/core/constant/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/admin_only_widget.dart';
import '../provider/camera_provider.dart';

class CameraDetailScreen extends StatefulWidget {
  final int cameraId;

  const CameraDetailScreen({super.key, required this.cameraId});

  @override
  State<CameraDetailScreen> createState() => _CameraDetailScreenState();
}

class _CameraDetailScreenState extends State<CameraDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CameraProvider>().fetchCameraById(widget.cameraId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<CameraProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 64),
                  const SizedBox(height: 16),
                  Text(provider.error!, style: AppTextStyles.bodyLarge()),
                  TextButton(
                    onPressed: () => provider.fetchCameraById(widget.cameraId),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final camera = provider.selectedCamera;
          if (camera == null) return const SizedBox();

          final isOnline = camera.status == 'online';

          return CustomScrollView(
            slivers: [
              // 1. Hero Header with Thumbnail
              SliverAppBar(
                expandedHeight: 250.h,
                pinned: true,
                backgroundColor: AppColors.primary,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Camera Feed / Thumbnail
                      camera.thumbnail != null
                          ? Image.network(
                              camera.thumbnail!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                            )
                          : _buildPlaceholder(),
                      // Gradient Overlay for readability
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.4),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.4),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      // Status Badge Overlay
                      Positioned(
                        bottom: 20.h,
                        left: 20.w,
                        child: _buildStatusBadge(isOnline),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Camera Information
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  camera.name,
                                  style: AppTextStyles.heading2(color: AppColors.textPrimary),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'ID: #${camera.id}',
                                  style: AppTextStyles.labelLarge(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          _buildQuickToggle(isOnline),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Information Grid
                      _buildInfoSection(
                        title: 'Location Details',
                        items: [
                          _InfoTile(
                            icon: Icons.location_on_outlined,
                            label: 'Location',
                            value: camera.location,
                          ),
                          _InfoTile(
                            icon: Icons.map_outlined,
                            label: 'Zone',
                            value: camera.zone.name.isEmpty 
                                ? 'Zone #${camera.zone.id}' 
                                : camera.zone.name,
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 24.h),

                      _buildInfoSection(
                        title: 'Technical Specification',
                        items: [
                          _InfoTile(
                            icon: Icons.wifi_tethering_outlined,
                            label: 'Stream URL',
                            value: camera.streamUrl,
                            isCopyable: true,
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      if (camera.createdAt != null)
                        _buildInfoSection(
                          title: 'History',
                          items: [
                            _InfoTile(
                              icon: Icons.history_outlined,
                              label: 'Registered On',
                              value: _formatDate(camera.createdAt!),
                            ),
                            if (camera.updatedAt != null)
                              _InfoTile(
                                icon: Icons.update_outlined,
                                label: 'Last Activity',
                                value: _formatDate(camera.updatedAt!),
                              ),
                          ],
                        ),

                      SizedBox(height: 32.h),

                      // Action Buttons (Admin Only)
                      AdminOnly(
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  context.pushNamed(
                                    AppRouteConstants.editCamera,
                                    extra: camera,
                                  );
                                },
                                icon: const Icon(Icons.edit_outlined),
                                label: const Text('Edit Details'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: provider.isDeleting
                                    ? null
                                    : () => _showDeleteConfirmation(context, provider, camera.id!),
                                icon: provider.isDeleting
                                    ? SizedBox(
                                        width: 18.w,
                                        height: 18.h,
                                        child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.red),
                                      )
                                    : const Icon(Icons.delete_outline, color: Colors.red),
                                label: Text(
                                  provider.isDeleting ? 'Deleting...' : 'Delete',
                                  style: const TextStyle(color: Colors.red),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.red),
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  void _showDeleteConfirmation(BuildContext context, CameraProvider provider, int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Camera'),
        content: const Text('Are you sure you want to delete this camera? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              await provider.deleteCamera(id);
              if (provider.error == null) {
                if (mounted) {
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    const SnackBar(content: Text('Camera deleted successfully'), backgroundColor: AppColors.success),
                  );
                  this.context.pop(); // Go back to list
                }
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    SnackBar(content: Text(provider.error!), backgroundColor: Colors.red),
                  );
                }
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickToggle(bool isOnline) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isOnline ? AppColors.success.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        isOnline ? Icons.power_settings_new : Icons.power_off,
        color: isOnline ? AppColors.success : Colors.grey,
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: AppColors.primary,
      child: Center(
        child: Icon(
          Icons.videocam_outlined,
          color: Colors.white24,
          size: 80.sp,
        ),
      ),
    );
  }

  Widget _buildStatusBadge(bool isOnline) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isOnline ? AppColors.success : AppColors.textSecondary,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: isOnline ? AppColors.success : AppColors.textSecondary,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            isOnline ? 'LIVE' : 'OFFLINE',
            style: AppTextStyles.labelSmall(
              color: Colors.white,
              weight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection({required String title, required List<Widget> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.titleMedium(color: AppColors.primary, weight: FontWeight.bold),
        ),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: items,
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isCopyable;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.isCopyable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.labelSmall(color: Colors.grey)),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: AppTextStyles.bodyMedium(weight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          if (isCopyable)
            IconButton(
              icon: Icon(Icons.copy_rounded, size: 18.sp, color: AppColors.textSecondary),
              onPressed: () {
                // Implement copy logic
              },
            ),
        ],
      ),
    );
  }
}
