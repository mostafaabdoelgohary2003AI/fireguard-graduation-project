class AlertPayload {
  final String type;
  final String eventId;
  final String cameraId;
  final String cameraName;
  final String location;
  final String zone;
  final String eventType;
  final double aiConfidence;
  final DateTime detectedAt;

  AlertPayload({
    required this.type,
    required this.eventId,
    required this.cameraId,
    required this.cameraName,
    required this.location,
    required this.zone,
    required this.eventType,
    required this.aiConfidence,
    required this.detectedAt,
  });

  factory AlertPayload.fromMap(Map<String, dynamic> data) {
    return AlertPayload(
      type: data['type']?.toString() ?? '',
      eventId: data['event_id']?.toString() ?? '',
      cameraId: data['camera_id']?.toString() ?? '',
      cameraName: data['camera_name']?.toString() ?? '',
      location: data['location']?.toString() ?? '',
      zone: data['zone']?.toString() ?? '',
      eventType: data['event_type']?.toString() ?? '',
      aiConfidence: double.tryParse(data['ai_confidence']?.toString() ?? '0') ?? 0.0,
      detectedAt: data['detected_at'] != null 
          ? DateTime.tryParse(data['detected_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'event_id': eventId,
      'camera_id': cameraId,
      'camera_name': cameraName,
      'location': location,
      'zone': zone,
      'event_type': eventType,
      'ai_confidence': aiConfidence.toString(),
      'detected_at': detectedAt.toIso8601String(),
    };
  }
}
