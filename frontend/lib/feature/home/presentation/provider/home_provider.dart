import 'package:flutter/material.dart';
import '../../domain/entities/recent_activity_entity.dart';
import '../../../../core/services/database_service.dart';
import '../../../../core/services/firebase_notifications.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class HomeProvider extends ChangeNotifier {
  bool _isAlertSimulated = false;
  bool _isRealAlertActive = false;
  List<RecentActivityEntity> _recentActivities = [];
  StreamSubscription? _notificationSubscription;

  bool get isAlertSimulated => _isAlertSimulated;
  bool get isRealAlertActive => _isRealAlertActive;
  bool get isSystemAlert => _isAlertSimulated || _isRealAlertActive;
  
  List<RecentActivityEntity> get recentActivities => _recentActivities;

  HomeProvider() {
    loadActivities();
    _listenToNotifications();
  }

  void _listenToNotifications() {
    _notificationSubscription = FirebaseNotifications.notificationStream.listen((alert) {
      if (alert.type == 'fire_alert') {
        _isRealAlertActive = true;
        loadActivities();
      }
    });
  }

  @override
  void dispose() {
    _notificationSubscription?.cancel();
    super.dispose();
  }

  Future<void> loadActivities() async {
    final alerts = await DatabaseService.instance.getAllNotifications();
    
    _recentActivities = alerts.map((alert) {
      return RecentActivityEntity(
        id: alert.eventId,
        title: "FIRE ALERT: ${alert.cameraName}",
        value: "${alert.eventType} - ${alert.location}",
        timestamp: DateFormat('MMM dd, yyyy').format(alert.detectedAt),
        trailing: DateFormat('HH:mm').format(alert.detectedAt),
      );
    }).toList();

    notifyListeners();
  }

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

  void resolveAlert() {
    _isRealAlertActive = false;
    notifyListeners();
  }
}
