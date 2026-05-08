/// Camera model representing a camera device.
/// This model holds all necessary information for a camera.
/// TODO: Integrate with backend API for persistence.
class Camera {
  final String id;
  final String name;
  final String location;
  final String streamUrl;
  final Zone zone;
  final String? imagePath; // Local path or network URL

  Camera({
    required this.id,
    required this.name,
    required this.location,
    required this.streamUrl,
    required this.zone,
    this.imagePath,
  });

  /// Creates a copy with updated fields
  Camera copyWith({
    String? id,
    String? name,
    String? location,
    String? streamUrl,
    Zone? zone,
    String? imagePath,
  }) {
    return Camera(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      streamUrl: streamUrl ?? this.streamUrl,
      zone: zone ?? this.zone,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  String toString() {
    return 'Camera(id: $id, name: $name, location: $location, streamUrl: $streamUrl, zone: $zone, imagePath: $imagePath)';
  }
}

/// Zone model representing a camera zone/area.
/// This model defines zones for organizing cameras.
/// TODO: Integrate with backend API for zone management.
class Zone {
  final String id;
  final String name;

  const Zone({required this.id, required this.name});

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

/// In-memory storage for cameras (replace with backend later)
/// TODO: Replace with proper backend service
List<Camera> cameras = [];

/// In-memory storage for zones (replace with backend later)
/// TODO: Replace with proper backend service
List<Zone> zones = [
  const Zone(id: '1', name: 'Zone A'),
  const Zone(id: '2', name: 'Zone B'),
  const Zone(id: '3', name: 'Zone C'),
];
