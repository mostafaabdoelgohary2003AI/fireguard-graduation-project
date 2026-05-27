import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/camera_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/spacing_widget.dart';
import '../provider/camera_provider.dart';

class EditCameraScreen extends StatefulWidget {
  final Camera camera;

  const EditCameraScreen({super.key, required this.camera});

  @override
  State<EditCameraScreen> createState() => _EditCameraScreenState();
}

class _EditCameraScreenState extends State<EditCameraScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  Zone? _selectedZone;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.camera.name);
    _locationController = TextEditingController(text: widget.camera.location);
    
    // Fetch zones and set initial selection
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<CameraProvider>();
      await provider.fetchZones();
      if (mounted) {
        setState(() {
          _selectedZone = provider.zones.firstWhere(
            (z) => z.id == widget.camera.zone.id,
            orElse: () => widget.camera.zone,
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _updateCamera() async {
    if (!_formKey.currentState!.validate()) return;

    final patchData = <String, dynamic>{};
    if (_nameController.text != widget.camera.name) patchData['name'] = _nameController.text;
    if (_locationController.text != widget.camera.location) patchData['location'] = _locationController.text;
    if (_selectedZone?.id != widget.camera.zone.id) patchData['zone'] = _selectedZone?.id;

    if (patchData.isEmpty) {
      context.pop();
      return;
    }

    final provider = context.read<CameraProvider>();
    await provider.updateCamera(widget.camera.id!, patchData);

    if (mounted) {
      if (provider.error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Camera updated successfully'), backgroundColor: AppColors.success),
        );
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(provider.error!), backgroundColor: Colors.red),
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
        title: Text('Edit Camera', style: AppTextStyles.heading3()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
      ),
      body: Consumer<CameraProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Camera Name',
                    icon: Icons.videocam_outlined,
                    validator: (v) => v!.isEmpty ? 'Please enter name' : null,
                  ),
                  const VerticalSpace(16),
                  _buildTextField(
                    controller: _locationController,
                    label: 'Location',
                    icon: Icons.location_on_outlined,
                    validator: (v) => v!.isEmpty ? 'Please enter location' : null,
                  ),
                  const VerticalSpace(16),
                  DropdownButtonFormField<Zone>(
                    initialValue: _selectedZone,
                    decoration: InputDecoration(
                      labelText: 'Zone',
                      prefixIcon: const Icon(Icons.map_outlined),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
                    ),
                    items: provider.zones.map((z) => DropdownMenuItem(value: z, child: Text(z.name))).toList(),
                    onChanged: (val) => setState(() => _selectedZone = val),
                    validator: (v) => v == null ? 'Please select a zone' : null,
                  ),
                  const VerticalSpace(32),
                  AppButton(
                    text: 'Save Changes',
                    isLoading: provider.isUpdating,
                    onPressed: _updateCamera,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
      ),
    );
  }
}
