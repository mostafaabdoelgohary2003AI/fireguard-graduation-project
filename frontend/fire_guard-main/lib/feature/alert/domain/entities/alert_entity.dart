class AlertEntity {
  final String id;
  final String location;
  final String time;
  final double aiConfidence;
  final String cameraName;
  final bool isLive;

  const AlertEntity({
    required this.id,
    required this.location,
    required this.time,
    required this.aiConfidence,
    required this.cameraName,
    required this.isLive,
  });
}
