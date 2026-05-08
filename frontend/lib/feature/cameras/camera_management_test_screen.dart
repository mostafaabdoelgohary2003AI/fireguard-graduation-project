import 'package:flutter/material.dart';
import '../../../core/widgets/add_camera_button.dart';
import '../../../core/widgets/delete_camera_button.dart';

/// Test screen to demonstrate working camera management buttons
/// This screen shows how to properly add the buttons to avoid UI blocking issues
class CameraManagementTestScreen extends StatelessWidget {
  const CameraManagementTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera Management Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SAFE WORKING EXAMPLE: Buttons in a Column with proper spacing
            const AddCameraButton(),
            const SizedBox(height: 20),
            const DeleteCameraButton(),

            const SizedBox(height: 40),

            // ALTERNATIVE: Buttons in a Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                AddCameraButton(),
                SizedBox(width: 20),
                DeleteCameraButton(),
              ],
            ),

            const SizedBox(height: 40),

            // TEST BUTTON: Simple button to verify navigation works
            ElevatedButton(
              onPressed: () {
                print("BUTTON CLICKED");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(title: const Text('Test Screen')),
                      body: const Center(child: Text('Navigation works!')),
                    ),
                  ),
                );
              },
              child: const Text("Test Button"),
            ),
          ],
        ),
      ),
    );
  }
}
