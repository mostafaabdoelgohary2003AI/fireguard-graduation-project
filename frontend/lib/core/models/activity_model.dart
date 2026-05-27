import 'package:intl/intl.dart';

/// Maps a single event from api/events/.
class ActivityEvent {
  final int id;
  final int cameraId;
  final String cameraName;
  final String cameraLocation;
  final String cameraStatus;
  final String zoneName;
  final int zoneId;
  final String eventType;
  final String status; // active | resolved
  final double aiConfidence;
  final String? snapshot;
  final String? notes;
  final DateTime detectedAt;
  final DateTime? resolvedAt;

  ActivityEvent({
    required this.id,
    required this.cameraId,
    required this.cameraName,
    required this.cameraLocation,
    required this.cameraStatus,
    required this.zoneName,
    required this.zoneId,
    required this.eventType,
    required this.status,
    required this.aiConfidence,
    this.snapshot,
    this.notes,
    required this.detectedAt,
    this.resolvedAt,
  });

  factory ActivityEvent.fromJson(Map<String, dynamic> json) {
    final cameraDetail = json['camera_detail'] as Map<String, dynamic>? ?? {};
    return ActivityEvent(
      id: json['id'] ?? 0,
      cameraId: json['camera'] ?? cameraDetail['id'] ?? 0,
      cameraName: cameraDetail['name'] ?? '',
      cameraLocation: cameraDetail['location'] ?? '',
      cameraStatus: cameraDetail['status'] ?? '',
      zoneName: json['zone_name'] ?? '',
      zoneId: json['zone_id'] ?? 0,
      eventType: json['event_type'] ?? '',
      status: json['status'] ?? 'pending',
      aiConfidence: (json['ai_confidence'] as num?)?.toDouble() ?? 0.0,
      snapshot: json['snapshot'],
      notes: json['notes'],
      detectedAt: json['detected_at'] != null
          ? DateTime.parse(json['detected_at'])
          : DateTime.now(),
      resolvedAt: json['resolved_at'] != null
          ? DateTime.parse(json['resolved_at'])
          : null,
    );
  }
  ActivityEvent copyWith({
    int? id,
    int? cameraId,
    String? cameraName,
    String? cameraLocation,
    String? cameraStatus,
    String? zoneName,
    int? zoneId,
    String? eventType,
    String? status,
    double? aiConfidence,
    String? snapshot,
    String? notes,
    DateTime? detectedAt,
    DateTime? resolvedAt,
  }) {
    return ActivityEvent(
      id: id ?? this.id,
      cameraId: cameraId ?? this.cameraId,
      cameraName: cameraName ?? this.cameraName,
      cameraLocation: cameraLocation ?? this.cameraLocation,
      cameraStatus: cameraStatus ?? this.cameraStatus,
      zoneName: zoneName ?? this.zoneName,
      zoneId: zoneId ?? this.zoneId,
      eventType: eventType ?? this.eventType,
      status: status ?? this.status,
      aiConfidence: aiConfidence ?? this.aiConfidence,
      snapshot: snapshot ?? this.snapshot,
      notes: notes ?? this.notes,
      detectedAt: detectedAt ?? this.detectedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
    );
  }

  /// Whether this event is still active (not yet resolved).
  bool get isActive => status == 'active';

  /// Alias kept for backward compatibility.
  bool get isPending => isActive;

  /// Whether this event is resolved.
  bool get isResolved => status == 'resolved';

  /// Formatted detection time, e.g. "May 24, 14:30".
  String get formattedTime =>
      DateFormat('MMM dd, HH:mm').format(detectedAt.toLocal());

  /// Short time label, e.g. "14:30".
  String get shortTime => DateFormat('HH:mm').format(detectedAt.toLocal());

  /// Capitalised event type label, e.g. "Fire".
  String get eventTypeLabel =>
      eventType.isNotEmpty ? eventType[0].toUpperCase() + eventType.substring(1) : '';
}
