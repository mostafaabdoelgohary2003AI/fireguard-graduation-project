import 'package:flutter/material.dart';
import '../../domain/entities/recent_activity_entity.dart';

class HomeProvider extends ChangeNotifier {
  bool _isAlertSimulated = false;

  final List<RecentActivityEntity> _recentActivities = const [
    RecentActivityEntity(
      id: "1",
      title: "LAST EVENT", // Can map from AppStrings in UI
      value: "14:22",
      timestamp: "OCT 24, 2023",
      trailing: "OCT 24, 2023",
    ),
    RecentActivityEntity(
      id: "2",
      title: "LOCATION", // Map AppStrings.location
      value: "Warehouse Section B",
      timestamp: "OCT 24, 2023",
    ),
  ];

  bool get isAlertSimulated => _isAlertSimulated;
  List<RecentActivityEntity> get recentActivities => _recentActivities;

  void simulateAlert(VoidCallback onNavigateCallback) {
    if (_isAlertSimulated) return;

    _isAlertSimulated = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 3), () {
      onNavigateCallback();
      _isAlertSimulated = false;
      notifyListeners();
    });
  }
}
