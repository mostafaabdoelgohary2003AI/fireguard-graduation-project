import 'package:flutter/material.dart';
import '../../core/models/camera_model.dart';
import '../../core/widgets/app_button.dart';

/// Screen for adding a new camera.
/// This screen provides a form to input camera details and add it to the system.
class AddCameraScreen extends StatefulWidget {
  const AddCameraScreen({super.key});

  @override
  State<AddCameraScreen> createState() => _AddCameraScreenState();
}

class _AddCameraScreenState extends State<AddCameraScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _streamUrlController = TextEditingController();
  final _imagePathController = TextEditingController();

  Zone? _selectedZone;
  bool _isAddingZone = false;
  final _newZoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _streamUrlController.dispose();
    _imagePathController.dispose();
    _newZoneController.dispose();
    super.dispose();
  }

  void _addZone() {
    if (_newZoneController.text.isNotEmpty) {
      final newZone = Zone(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _newZoneController.text,
      );
      setState(() {
        zones.add(newZone);
        _selectedZone = newZone;
        _isAddingZone = false;
        _newZoneController.clear();
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedZone != null) {
      final camera = Camera(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        location: _locationController.text,
        streamUrl: _streamUrlController.text,
        zone: _selectedZone!,
        imagePath: _imagePathController.text.isEmpty
            ? null
            : _imagePathController.text,
      );

      // Add to in-memory list (replace with backend call)
      // TODO: Integrate with backend API
      cameras.add(camera);

      // Print for debugging (remove in production)
      debugPrint('Added camera: $camera');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera added successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Camera'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Camera',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter camera details to connect it to your live feed.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  const BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Camera Details',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Camera Name',
                        hintText: 'Enter camera name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        prefixIcon: const Icon(Icons.camera_alt_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter camera name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Location',
                        hintText: 'Enter camera location',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        prefixIcon: const Icon(Icons.location_on_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter location';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _streamUrlController,
                      decoration: InputDecoration(
                        labelText: 'Stream URL',
                        hintText: 'Enter RTSP or HTTP stream URL',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        prefixIcon: const Icon(Icons.wifi_tethering_outlined),
                      ),
                      keyboardType: TextInputType.url,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter stream URL';
                        }
                        if (!Uri.parse(value).isAbsolute) {
                          return 'Please enter a valid URL';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Zone>(
                      initialValue: _selectedZone,
                      decoration: InputDecoration(
                        labelText: 'Zone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        prefixIcon: const Icon(Icons.map_outlined),
                      ),
                      items: zones.map((zone) {
                        return DropdownMenuItem(
                          value: zone,
                          child: Text(zone.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedZone = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a zone';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                      ),
                      onPressed: () {
                        setState(() {
                          _isAddingZone = !_isAddingZone;
                        });
                      },
                      icon: Icon(_isAddingZone ? Icons.close : Icons.add),
                      label: Text(_isAddingZone ? 'Cancel' : 'Add New Zone'),
                    ),
                    if (_isAddingZone) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _newZoneController,
                              decoration: InputDecoration(
                                labelText: 'New Zone Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 100,
                            child: AppButton(
                              text: 'Add',
                              icon: Icons.add,
                              onPressed: _addZone,
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _imagePathController,
                      decoration: InputDecoration(
                        labelText: 'Image Path (Optional)',
                        hintText: 'Enter image path or leave empty',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        prefixIcon: const Icon(Icons.image_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'Add Camera',
              icon: Icons.check,
              type: AppButtonType.primary,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
