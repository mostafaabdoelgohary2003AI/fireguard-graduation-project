enum NotificationStatus { active, resolved, falseAlarm }

class NotificationEntity {
  final String id;
  final String title;
  final String date;
  final NotificationStatus status;
  final String confidence;
  final String zone;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.confidence,
    required this.zone,
  });
}
