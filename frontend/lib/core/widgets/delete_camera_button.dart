import 'package:flutter/material.dart';
import 'app_button.dart';
import '../../feature/cameras/delete_camera_screen.dart';

class DeleteCameraButton extends StatelessWidget {
  const DeleteCameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: 'Delete Camera',
      icon: Icons.delete,
      type: AppButtonType.danger,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const DeleteCameraScreen()),
        );
      },
    );
  }
}
