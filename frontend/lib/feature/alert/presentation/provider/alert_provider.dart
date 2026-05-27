import 'package:flutter/material.dart';
import '../../domain/entities/alert_entity.dart';
import '../../../../core/models/notification_payload.dart';

class AlertProvider extends ChangeNotifier {
  late AlertEntity _currentAlert;

  AlertProvider({AlertPayload? payload}) {
    if (payload != null) {
      _currentAlert = AlertEntity(
        id: payload.eventId,
        location: payload.location,
        time: "${payload.detectedAt.hour}:${payload.detectedAt.minute.toString().padLeft(2, '0')}",
        aiConfidence: payload.aiConfidence,
        cameraName: payload.cameraName,
        isLive: true,
      );
    } else {
      _currentAlert = const AlertEntity(
        id: "alert_1",
        location: "Warehouse B",
        time: "14:22",
        aiConfidence: 98.4,
        cameraName: "CAM-02 // WAREHOUSE-B",
        isLive: true,
      );
    }
  }

  AlertEntity get currentAlert => _currentAlert;

  void dismissAlarm() {
    // Dismissal entity operations
    notifyListeners();
  }
}
