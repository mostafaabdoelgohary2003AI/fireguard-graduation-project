import 'package:flutter/material.dart';
import '../../core/models/camera_model.dart';

/// Screen for deleting cameras.
/// This screen displays a list of cameras with delete functionality.
class DeleteCameraScreen extends StatefulWidget {
  const DeleteCameraScreen({super.key});

  @override
  State<DeleteCameraScreen> createState() => _DeleteCameraScreenState();
}

class _DeleteCameraScreenState extends State<DeleteCameraScreen> {
  void _deleteCamera(Camera camera) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Camera'),
        content: Text('Are you sure you want to delete "${camera.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        cameras.remove(camera);
      });

      // TODO: Integrate with backend API for deletion
      debugPrint('Deleted camera: ${camera.name}');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Camera "${camera.name}" deleted successfully!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Camera'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: cameras.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No cameras available',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cameras.length,
              itemBuilder: (context, index) {
                final camera = cameras[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(Icons.camera_alt, color: Colors.white),
                    ),
                    title: Text(
                      camera.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location: ${camera.location}'),
                        Text('Zone: ${camera.zone.name}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteCamera(camera),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
