class CameraEntity {
  final String id;
  final String title;
  final bool isLive;

  const CameraEntity({
    required this.id,
    required this.title,
    this.isLive = true,
  });
}
