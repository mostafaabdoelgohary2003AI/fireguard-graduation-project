import 'package:intl/intl.dart';

/// Represents a nested camera inside a FireEvent response.
class CameraDetail {
  final int id;
  final String name;
  final String location;
  final int zone;
  final String zoneName;
  final String status;

  const CameraDetail({
    required this.id,
    required this.name,
    required this.location,
    required this.zone,
    required this.zoneName,
    required this.status,
  });

  factory CameraDetail.fromJson(Map<String, dynamic> json) => CameraDetail(
        id:       json['id']        as int,
        name:     json['name']      as String,
        location: json['location']  as String,
        zone:     json['zone']      as int,
        zoneName: json['zone_name'] as String? ?? '',
        status:   json['status']    as String? ?? 'unknown',
      );
}

/// Mirrors the FireEventSerializer response from the backend.
///
/// Fields:
///   id, camera, camera_detail, zone_name, zone_id,
///   event_type, status, ai_confidence, snapshot, notes,
///   detected_at, resolved_at
class EventModel {
  final int id;
  final int camera;
  final CameraDetail? cameraDetail;
  final String zoneName;
  final int? zoneId;

  /// 'fire' | 'smoke'
  final String eventType;

  /// 'active' | 'resolved' | 'false_alarm'
  final String status;

  final double aiConfidence;
  final String? snapshot;
  final String? notes;
  final DateTime detectedAt;
  final DateTime? resolvedAt;

  const EventModel({
    required this.id,
    required this.camera,
    this.cameraDetail,
    required this.zoneName,
    this.zoneId,
    required this.eventType,
    required this.status,
    required this.aiConfidence,
    this.snapshot,
    this.notes,
    required this.detectedAt,
    this.resolvedAt,
  });

  // ── Convenience getters ────────────────────────────────────────────────

  bool get isActive  => status == 'active';
  bool get isFire    => eventType == 'fire';
  bool get isSmoke   => eventType == 'smoke';

  String get cameraName => cameraDetail?.name ?? 'Camera #$camera';
  String get location   => cameraDetail?.location ?? 'Unknown location';

  String get formattedConfidence => '${aiConfidence.toStringAsFixed(1)}%';

  String get formattedDate =>
      DateFormat('MMM d, yyyy • HH:mm').format(detectedAt.toLocal());

  String get shortTime =>
      DateFormat('HH:mm:ss').format(detectedAt.toLocal());

  String get displayTitle =>
      isFire ? 'FIRE DETECTED' : 'SMOKE DETECTED';

  // ── fromJson ───────────────────────────────────────────────────────────

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final camRaw = json['camera_detail'];

    return EventModel(
      id:             json['id']             as int,
      camera:         json['camera']         as int,
      cameraDetail:   camRaw != null
          ? CameraDetail.fromJson(camRaw as Map<String, dynamic>)
          : null,
      zoneName:       json['zone_name']      as String? ?? '',
      zoneId:         json['zone_id']        as int?,
      eventType:      json['event_type']     as String,
      status:         json['status']         as String,
      aiConfidence:   (json['ai_confidence'] as num).toDouble(),
      snapshot:       json['snapshot']       as String?,
      notes:          json['notes']          as String?,
      detectedAt:     DateTime.parse(json['detected_at'] as String),
      resolvedAt:     json['resolved_at'] != null
          ? DateTime.parse(json['resolved_at'] as String)
          : null,
    );
  }

  /// Construct an EventModel from the FCM data payload (all values are strings).
  factory EventModel.fromFcmData(Map<String, dynamic> data) {
    return EventModel(
      id:           int.tryParse(data['event_id']?.toString() ?? '0') ?? 0,
      camera:       int.tryParse(data['camera_id']?.toString() ?? '0') ?? 0,
      cameraDetail: null,
      zoneName:     data['zone']?.toString() ?? '',
      eventType:    data['event_type']?.toString() ?? 'fire',
      status:       'active',
      aiConfidence: double.tryParse(data['ai_confidence']?.toString() ?? '0') ?? 0,
      detectedAt:   data['detected_at'] != null
          ? DateTime.tryParse(data['detected_at'].toString()) ?? DateTime.now()
          : DateTime.now(),
      resolvedAt: null,
    );
  }

  EventModel copyWith({String? status, DateTime? resolvedAt}) => EventModel(
        id:           id,
        camera:       camera,
        cameraDetail: cameraDetail,
        zoneName:     zoneName,
        zoneId:       zoneId,
        eventType:    eventType,
        status:       status   ?? this.status,
        aiConfidence: aiConfidence,
        snapshot:     snapshot,
        notes:        notes,
        detectedAt:   detectedAt,
        resolvedAt:   resolvedAt ?? this.resolvedAt,
      );
}
