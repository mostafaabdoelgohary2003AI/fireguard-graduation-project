import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/models/event_model.dart';
import '../../../../core/services/alarm_service.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/event_service.dart';

class AlertProvider extends ChangeNotifier {
  EventModel? _currentAlert;
  bool        _isLoading = false;
  String?     _error;

  EventModel? get currentAlert  => _currentAlert;
  bool        get isLoading     => _isLoading;
  String?     get error         => _error;
  bool        get hasActiveAlert =>
      _currentAlert != null && _currentAlert!.isActive;

  // ── Incoming alert ────────────────────────────────────────────────────────

  /// Called by HomeProvider / NotificationService when a new event arrives.
  void onNewAlert(EventModel event) {
    _currentAlert = event;
    notifyListeners();
    AlarmService().trigger();
  }

  // ── Stop alarm only ───────────────────────────────────────────────────────

  Future<void> stopAlarm() async {
    await AlarmService().stop();
    notifyListeners();
  }

  // ── Resolve event (mark as resolved) ─────────────────────────────────────

  Future<bool> resolveEvent() async {
    if (_currentAlert == null) return false;
    _setLoading(true);
    try {
      _currentAlert = await EventService.resolveEvent(_currentAlert!.id);
      await AlarmService().stop();
      _error = null;
      return true;
    } on DioException catch (e) {
      _error = parseApiError(e);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ── Mark false alarm ─────────────────────────────────────────────────────

  Future<bool> markFalseAlarm() async {
    if (_currentAlert == null) return false;
    _setLoading(true);
    try {
      _currentAlert = await EventService.markFalseAlarm(_currentAlert!.id);
      await AlarmService().stop();
      _error = null;
      return true;
    } on DioException catch (e) {
      _error = parseApiError(e);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ── Clear ─────────────────────────────────────────────────────────────────

  void clearAlert() {
    _currentAlert = null;
    _error        = null;
    AlarmService().stop();
    notifyListeners();
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
