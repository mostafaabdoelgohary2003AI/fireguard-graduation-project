import 'dart:io';

import 'package:dio/dio.dart';

import 'endpoints.dart';

class PredictResult {
  final String eventType;
  final double confidence;
  final List<Map<String, dynamic>> detections;

  const PredictResult({
    required this.eventType,
    required this.confidence,
    required this.detections,
  });

  bool get isFireDetected => eventType != 'none';

  factory PredictResult.fromJson(Map<String, dynamic> json) {
    return PredictResult(
      eventType: json['event_type'] as String? ?? 'none',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      detections: (json['detections'] as List<dynamic>?)
              ?.map((e) => Map<String, dynamic>.from(e as Map))
              .toList() ??
          [],
    );
  }
}

class AiService {
  late final Dio _dio;

  AiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.aiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }

  /// Sends [imageFile] to the AI /predict endpoint for the given [cameraId].
  /// Returns a [PredictResult] with event_type, confidence, and detections.
  Future<PredictResult> predict({
    required File imageFile,
    int cameraId = 1,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split(Platform.pathSeparator).last,
      ),
    });

    final response = await _dio.post(
      Endpoints.predict,
      data: formData,
      queryParameters: {'camera_id': cameraId},
      options: Options(contentType: 'multipart/form-data'),
    );

    return PredictResult.fromJson(response.data as Map<String, dynamic>);
  }
}
