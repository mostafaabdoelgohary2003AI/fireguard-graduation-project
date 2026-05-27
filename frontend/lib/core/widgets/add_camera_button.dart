import 'package:flutter/material.dart';
import '../../../../core/widgets/app_button.dart';
import '../../feature/cameras/add_camera_screen.dart';

import 'admin_only_widget.dart';

class AddCameraButton extends StatelessWidget {
  const AddCameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminOnly(
      child: AppButton(
        text: 'Add Camera',
        icon: Icons.add,
        type: AppButtonType.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCameraScreen()),
          );
        },
      ),
    );
  }
}
