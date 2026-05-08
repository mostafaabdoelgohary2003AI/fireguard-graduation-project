import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/models/event_model.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/services/event_service.dart';

class HistoryProvider extends ChangeNotifier {
  List<EventModel> _events     = [];
  bool             _isLoading  = false;
  String?          _error;
  String           _filter     = 'all'; // 'all' | 'active' | 'resolved' | 'false_alarm'

  List<EventModel> get events => _filter == 'all'
      ? _events
      : _events.where((e) => e.status == _filter).toList();
  bool    get isLoading => _isLoading;
  String? get error     => _error;
  String  get filter    => _filter;

  // Keep the old tab names for the UI.
  final List<String> tabs = const [
    'All', 'Active', 'Resolved', 'False Alarm',
  ];

  String tabToFilter(String tab) => switch (tab.toLowerCase()) {
        'active'      => 'active',
        'resolved'    => 'resolved',
        'false alarm' => 'false_alarm',
        _             => 'all',
      };

  // ── Load ──────────────────────────────────────────────────────────────────

  Future<void> loadHistory() async {
    _isLoading = true;
    _error     = null;
    notifyListeners();

    try {
      _events = await EventService.getEvents();
      // Most recent first.
      _events.sort((a, b) => b.detectedAt.compareTo(a.detectedAt));
    } on DioException catch (e) {
      _error = parseApiError(e);
      debugPrint('HistoryProvider: $e');
    } catch (e) {
      _error = 'Failed to load history.';
      debugPrint('HistoryProvider: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // ── Filter ────────────────────────────────────────────────────────────────

  void selectTab(String tab) {
    _filter = tabToFilter(tab);
    notifyListeners();
  }
}
