import 'package:fire_gaurd/core/services/endpoints.dart';

/// Camera model representing a camera device.
class Camera {
  final int? id;
  final String name;
  final String location;
  final String streamUrl;
  final Zone zone;
  final String? thumbnail;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Camera({
    this.id,
    required this.name,
    required this.location,
    required this.streamUrl,
    required this.zone,
    this.thumbnail,
    this.status = 'online',
    this.createdAt,
    this.updatedAt,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    Zone parsedZone;
    // Extract zone info from various possible formats
    final int? zoneId = json['zone'] is int ? json['zone'] : (json['zone'] is Map ? json['zone']['id'] : null);
    final String zoneName = json['zone_name'] ?? (json['zone'] is Map ? json['zone']['name'] : '');

    if (json['zone_details'] != null && json['zone_details'] is Map) {
      parsedZone = Zone.fromJson(json['zone_details']);
    } else {
      parsedZone = Zone(id: zoneId, name: zoneName);
    }

    return Camera(
      id: json['id'],
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      streamUrl: json['stream_url'] ?? '',
      zone: parsedZone,
      thumbnail: _normalizeImageUrl(json['thumbnail'] ?? json['image_path']),
      status: json['status'] ?? 'online',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  /// Normalize a thumbnail URL from Django: if it's a relative path, prepend
  /// the backend base URL so Image.network can load it.
  static String? _normalizeImageUrl(dynamic raw) {
    if (raw == null) return null;
    final s = raw.toString();
    if (s.isEmpty) return null;
    if (s.startsWith('http://') || s.startsWith('https://')) return s;
    // Relative path from Django (e.g. /media/cameras/img.jpg)
    final base = Endpoints.baseUrl.endsWith('/')
        ? Endpoints.baseUrl.substring(0, Endpoints.baseUrl.length - 1)
        : Endpoints.baseUrl;
    return '$base$s';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'zone': zone.id,
      'status': status,
    };
  }

  @override
  String toString() {
    return 'Camera(id: $id, name: $name, location: $location, zone: ${zone.name}, status: $status)';
  }
}

/// Zone model representing a camera zone/area.
class Zone {
  final int? id;
  final String name;

  const Zone({this.id, required this.name});

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Zone(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Zone && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

/// Camera statistics representing dynamic data from api/cameras/stats/.
class CameraStats {
  final int totalUnits;
  final int onlineNow;
  final int offline;

  CameraStats({
    required this.totalUnits,
    required this.onlineNow,
    required this.offline,
  });

  factory CameraStats.fromJson(Map<String, dynamic> json) {
    return CameraStats(
      totalUnits: json['total_units'] ?? 0,
      onlineNow: json['online_now'] ?? 0,
      offline: json['offline'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'CameraStats(totalUnits: $totalUnits, onlineNow: $onlineNow, offline: $offline)';
  }
}

// These are still used by some UI components as placeholders
List<Camera> cameras = [];
List<Zone> zones = [];
