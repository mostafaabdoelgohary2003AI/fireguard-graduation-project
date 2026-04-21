import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

const String predictUrl = 'http://localhost:8001/predict';

Future<void> captureAndPredict() async {
  final picker = ImagePicker();
  final XFile? photo = await picker.pickImage(source: ImageSource.camera);

  if (photo == null) {
    print('No image captured.');
    return;
  }

  try {
    final request = http.MultipartRequest('POST', Uri.parse(predictUrl));
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
        print('🔥 FIRE DETECTED');
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
