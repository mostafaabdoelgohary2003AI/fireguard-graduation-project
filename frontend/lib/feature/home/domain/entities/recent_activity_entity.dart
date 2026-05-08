class RecentActivityEntity {
  final String id;
  final String title;
  final String value;
  final String timestamp;
  final String? trailing;

  const RecentActivityEntity({
    required this.id,
    required this.title,
    required this.value,
    required this.timestamp,
    this.trailing,
  });
}
