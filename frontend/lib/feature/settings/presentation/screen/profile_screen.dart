import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/spacing_widget.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../auth/provider/auth_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthProvider>().user;
    _firstNameController = TextEditingController(text: user?.firstName ?? '');
    _lastNameController = TextEditingController(text: user?.lastName ?? '');
    _phoneController = TextEditingController(text: user?.phone ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final provider = context.read<AuthProvider>();
    
    final user = provider.user;
    if (user == null || user.id == null) return;
    
    // Construct the payload for PATCH request
    final payload = {
      "id": user.id, // ID goes in the body, not the URL!
      "first_name": _firstNameController.text.trim(),
      "last_name": _lastNameController.text.trim(),
      "profile": {
        "phone": _phoneController.text.trim(),
      }
    };

    final success = await provider.updateProfile(user.id!, payload);

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: AppColors.success,
          ),
        );
        context.pop(); // Go back after success
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage ?? 'Failed to update profile'),
            backgroundColor: Colors.red,
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
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        title: Text("Account Profile", style: AppTextStyles.heading3()),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          final user = provider.user;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header / Avatar Placeholder
                Center(
                  child: Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        (user?.firstName?.isNotEmpty == true 
                            ? user!.firstName![0].toUpperCase() 
                            : user?.name?.isNotEmpty == true 
                                ? user!.name![0].toUpperCase() 
                                : '?'),
                        style: AppTextStyles.heading1(color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
                const VerticalSpace(32),

                // Read-only info
                _buildInfoField("Username", user?.name ?? "N/A"),
                const VerticalSpace(16),
                _buildInfoField("Email", user?.email ?? "N/A"),
                const VerticalSpace(24),

                // Editable Fields
                Text(
                  "Personal Information",
                  style: AppTextStyles.titleMedium(color: AppColors.textSecondary),
                ),
                const VerticalSpace(16),
                _buildEditableField("First Name", _firstNameController),
                const VerticalSpace(16),
                _buildEditableField("Last Name", _lastNameController),
                const VerticalSpace(16),
                _buildEditableField("Phone Number", _phoneController, keyboardType: TextInputType.phone),
                const VerticalSpace(48),

                // Save Button
                AppButton(
                  text: provider.isLoading ? "Saving..." : "Save Changes",
                  onPressed: provider.isLoading ? () {} : _saveProfile,
                  type: AppButtonType.primary,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelMedium(color: AppColors.textSecondary)),
        const VerticalSpace(8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: AppColors.input,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(value, style: AppTextStyles.bodyLarge(color: AppColors.textPrimary)),
        ),
      ],
    );
  }

  Widget _buildEditableField(
    String label, 
    TextEditingController controller, 
    {TextInputType keyboardType = TextInputType.text}
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelMedium(color: AppColors.textSecondary)),
        const VerticalSpace(8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: AppTextStyles.bodyLarge(color: AppColors.textPrimary),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.card,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.input, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
