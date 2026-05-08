import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/models/event_model.dart';
import '../../../../core/services/event_service.dart';
import '../../../../core/services/notification_service.dart';

/// Provides the home screen with live system stats, recent events, and
/// connection status. Polls the backend every 10 seconds as a reliable
/// fallback for when FCM is unavailable.
class HomeProvider extends ChangeNotifier {
  List<EventModel>   _recentEvents    = [];
  Map<String, int>   _stats           = {};
  bool               _isLoading       = false;
  bool               _isConnected     = false;
  String             _connectionStatus = 'Checking…';
  Timer?             _pollTimer;
  int?               _lastAlertId;

  /// Called by the screen when a new alert must be displayed.
  /// Wired to [AlertProvider.onNewAlert] + navigation in the screen.
  void Function(EventModel)? onNewAlert;

  // ── Getters ───────────────────────────────────────────────────────────────

  List<EventModel> get recentEvents     => _recentEvents;
  Map<String, int> get stats            => _stats;
  bool             get isLoading        => _isLoading;
  bool             get isConnected      => _isConnected;
  String           get connectionStatus => _connectionStatus;

  int get totalCameras  => _stats['total_cameras'] ?? 0;
  int get activeAlerts  => _stats['active']         ?? 0;
  int get totalEvents   => _stats['total']          ?? 0;
  int get resolvedToday => _stats['resolved']       ?? 0;

  // ── Lifecycle ─────────────────────────────────────────────────────────────

  void initialize(void Function(EventModel) alertCallback) {
    onNewAlert = alertCallback;
    _loadDashboard();
    _startPolling();
    _listenToFcm();
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  // ── Data loading ──────────────────────────────────────────────────────────

  Future<void> refresh() => _loadDashboard();

  Future<void> _loadDashboard() async {
    _isLoading = true;
    notifyListeners();

    try {
      final results = await Future.wait([
        EventService.getStats(),
        EventService.getEvents(),
      ]);

      _stats        = results[0] as Map<String, int>;
      final all     = results[1] as List<EventModel>;
      _recentEvents = all.take(5).toList();

      _isConnected     = true;
      _connectionStatus = 'Connected';
    } catch (e) {
      _isConnected      = false;
      _connectionStatus = 'Disconnected';
      debugPrint('HomeProvider: dashboard load failed: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // ── Polling ───────────────────────────────────────────────────────────────

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(
      const Duration(seconds: 10),
      (_) => _pollActiveEvent(),
    );
  }

  Future<void> _pollActiveEvent() async {
    try {
      final event = await EventService.getActiveEvent();
      _isConnected     = true;
      _connectionStatus = 'Connected';

      if (event != null && event.id != _lastAlertId) {
        _lastAlertId = event.id;
        onNewAlert?.call(event);
      }
    } catch (e) {
      _isConnected      = false;
      _connectionStatus = 'Disconnected';
      debugPrint('HomeProvider: poll failed: $e');
    }
    notifyListeners();
  }

  // ── FCM fallback ──────────────────────────────────────────────────────────

  void _listenToFcm() {
    NotificationService.alertStream.listen((event) {
      if (event.id != _lastAlertId) {
        _lastAlertId = event.id;
        onNewAlert?.call(event);
      }
    });
  }
}
