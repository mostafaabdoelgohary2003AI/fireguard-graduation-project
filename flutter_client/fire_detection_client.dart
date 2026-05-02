import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

// Must be set at build time — no default works on real devices:
//   flutter run --dart-define=AI_SERVICE_URL=http://192.168.1.x:8001
const String _aiServiceUrl = String.fromEnvironment('AI_SERVICE_URL');

const String predictUrl = '$_aiServiceUrl/predict';

Future<void> captureAndPredict({int cameraId = 1}) async {
  final picker = ImagePicker();
  final XFile? photo = await picker.pickImage(source: ImageSource.camera);

  if (photo == null) {
    print('No image captured.');
    return;
  }

  try {
    final uri = Uri.parse(predictUrl).replace(
      queryParameters: {'camera_id': '$cameraId'},
    );
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', photo.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final eventType = data['event_type'];
      final confidence = data['confidence'];

      print('event_type: $eventType');
      print('confidence: $confidence');

      if (eventType != 'none') {
        print('FIRE DETECTED');
      } else {
        print('No fire');
      }
    } else {
      print('Error: ${response.statusCode} ${response.body}');
    }
  } on SocketException {
    print('Connection error: could not reach $predictUrl');
  } catch (e) {
    print('Unexpected error: $e');
  }
}
