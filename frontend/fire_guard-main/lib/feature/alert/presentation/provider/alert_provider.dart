import 'package:flutter/material.dart';
import '../../domain/entities/alert_entity.dart';

class AlertProvider extends ChangeNotifier {
  final AlertEntity _currentAlert = const AlertEntity(
    id: "alert_1",
    location: "Warehouse B",
    time: "14:22",
    aiConfidence: 98.4,
    cameraName: "CAM-02 // WAREHOUSE-B",
    isLive: true,
  );

  AlertEntity get currentAlert => _currentAlert;

  void dismissAlarm() {
    // Dismissal entity operations
    notifyListeners();
  }
}
