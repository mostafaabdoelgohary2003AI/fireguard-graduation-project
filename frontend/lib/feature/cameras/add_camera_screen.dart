import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../core/models/camera_model.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/spacing_widget.dart';
import 'presentation/provider/camera_provider.dart';

/// Screen for adding a new camera using the app's design system.
class AddCameraScreen extends StatefulWidget {
  const AddCameraScreen({super.key});

  @override
  State<AddCameraScreen> createState() => _AddCameraScreenState();
}

class _AddCameraScreenState extends State<AddCameraScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();

  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  Zone? _selectedZone;
  bool _isAddingZone = false;
  final _newZoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CameraProvider>().fetchZones();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _newZoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() => _pickedImage = image);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to pick image: ${e.toString()}'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  void _addZone() async {
    if (_newZoneController.text.trim().isEmpty) return;
    try {
      final newZone = await context.read<CameraProvider>().addZone(
            _newZoneController.text.trim(),
          );
      setState(() {
        _selectedZone = newZone;
        _isAddingZone = false;
        _newZoneController.clear();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add zone: ${e.toString()}'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedZone == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a zone'),
          backgroundColor: AppColors.warning,
        ),
      );
      return;
    }

    final camera = Camera(
      name: _nameController.text.trim(),
      location: _locationController.text.trim(),
      streamUrl: '',
      zone: _selectedZone!,
    );

    try {
      await context.read<CameraProvider>().addCamera(
            camera,
            localImagePath: _pickedImage?.path,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Camera added successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add camera: ${e.toString()}'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Camera', style: AppTextStyles.heading3()),
      ),
      body: Consumer<CameraProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Image Picker ──────────────────────────────────────────
                  Text(
                    'Camera Image',
                    style: AppTextStyles.bodyMedium(
                      color: AppColors.textSecondary,
                      weight: FontWeight.w600,
                    ),
                  ),
                  const VerticalSpace(10),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      height: 180.h,
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: _pickedImage != null
                              ? AppColors.primary
                              : AppColors.textSecondary.withValues(alpha: 0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.textSecondary.withValues(alpha: 0.08),
                            blurRadius: 10.r,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _pickedImage != null
                          ? _buildImagePreview()
                          : _buildImagePlaceholder(),
                    ),
                  ),

                  const VerticalSpace(24),

                  // ── Camera Details ────────────────────────────────────────
                  Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textSecondary.withValues(alpha: 0.1),
                          blurRadius: 10.r,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Camera Details',
                          style: AppTextStyles.titleMedium(weight: FontWeight.w700),
                        ),
                        const VerticalSpace(20),

                        // Name field
                        _buildTextField(
                          controller: _nameController,
                          label: 'Camera Name',
                          hint: 'e.g. Entrance Camera',
                          icon: Icons.videocam_outlined,
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Please enter camera name' : null,
                        ),
                        const VerticalSpace(16),

                        // Location field
                        _buildTextField(
                          controller: _locationController,
                          label: 'Location',
                          hint: 'e.g. Building A – Floor 2',
                          icon: Icons.location_on_outlined,
                          validator: (v) =>
                              (v == null || v.trim().isEmpty) ? 'Please enter location' : null,
                        ),
                        const VerticalSpace(16),

                        // Zone dropdown
                        _buildZoneDropdown(provider),
                        const VerticalSpace(4),

                        // Add new zone toggle
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                          ),
                          onPressed: () => setState(() => _isAddingZone = !_isAddingZone),
                          icon: Icon(
                            _isAddingZone ? Icons.close : Icons.add,
                            size: 18.sp,
                          ),
                          label: Text(
                            _isAddingZone ? 'Cancel' : 'Add New Zone',
                            style: AppTextStyles.bodyMedium(
                              color: AppColors.primary,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ),

                        if (_isAddingZone) ...[
                          const VerticalSpace(8),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _newZoneController,
                                  style: AppTextStyles.bodyMedium(),
                                  decoration: InputDecoration(
                                    labelText: 'New Zone Name',
                                    prefixIcon: const Icon(Icons.add_location_alt_outlined),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 14.w,
                                      vertical: 14.h,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              SizedBox(
                                width: 90.w,
                                child: AppButton(
                                  text: 'Add',
                                  icon: Icons.check,
                                  isLoading: provider.isLoading,
                                  onPressed: _addZone,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  const VerticalSpace(32),

                  // ── Submit Button ─────────────────────────────────────────
                  AppButton(
                    text: 'Add Camera',
                    icon: Icons.check,
                    type: AppButtonType.primary,
                    isLoading: provider.isLoading,
                    onPressed: _submit,
                  ),
                  const VerticalSpace(24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImagePreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(_pickedImage!.path),
            fit: BoxFit.cover,
          ),
          // Dark gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.4),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Remove button
          Positioned(
            top: 8.h,
            right: 8.w,
            child: GestureDetector(
              onTap: () => setState(() => _pickedImage = null),
              child: Container(
                padding: EdgeInsets.all(6.r),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 18.sp),
              ),
            ),
          ),
          // Tap to change label
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_outlined, color: Colors.white70, size: 14.sp),
                  SizedBox(width: 6.w),
                  Text(
                    'Tap to change image',
                    style: AppTextStyles.labelSmall(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_photo_alternate_outlined,
          size: 44.sp,
          color: AppColors.textSecondary.withValues(alpha: 0.5),
        ),
        const VerticalSpace(10),
        Text(
          'Pick Camera Image from Gallery',
          style: AppTextStyles.bodyMedium(
            color: AppColors.textSecondary,
            weight: FontWeight.w500,
          ),
        ),
        const VerticalSpace(4),
        Text(
          'Optional — tap to browse your photos',
          style: AppTextStyles.labelSmall(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: AppTextStyles.bodyMedium(),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      ),
    );
  }

  Widget _buildZoneDropdown(CameraProvider provider) {
    return DropdownButtonFormField<Zone>(
      initialValue: _selectedZone,
      decoration: InputDecoration(
        labelText: 'Zone',
        prefixIcon: const Icon(Icons.map_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      ),
      items: provider.zones
          .map((z) => DropdownMenuItem(value: z, child: Text(z.name)))
          .toList(),
      onChanged: (val) => setState(() => _selectedZone = val),
      validator: (v) => v == null ? 'Please select a zone' : null,
    );
  }
}
