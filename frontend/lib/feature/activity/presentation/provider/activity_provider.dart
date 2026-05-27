import 'package:fire_gaurd/core/models/activity_model.dart';
import 'package:fire_gaurd/feature/activity/data/repository/activity_repository.dart';
import 'package:flutter/material.dart';

enum ActivityFilter { all, active, resolved }

class ActivityProvider extends ChangeNotifier {
  final ActivityRepository repository;

  ActivityProvider({required this.repository});

  // ── State ──────────────────────────────────────────────────────────────────
  List<ActivityEvent> _recentEvents = [];
  List<ActivityEvent> _allEvents = [];
  ActivityFilter _filter = ActivityFilter.all;
  bool _hasActiveActivities = false;

  bool _isLoadingRecent = false;
  bool _isLoadingAll = false;
  String? _recentError;
  String? _allError;

  // ── Getters ────────────────────────────────────────────────────────────────
  List<ActivityEvent> get recentEvents => _recentEvents;
  ActivityFilter get filter => _filter;
  bool get hasActiveActivities => _hasActiveActivities;
  bool get isLoadingRecent => _isLoadingRecent;
  bool get isLoadingAll => _isLoadingAll;
  String? get recentError => _recentError;
  String? get allError => _allError;

  /// Returns the events shown in the history list, filtered client-side
  /// from the full [_allEvents] list based on [status] field ('active' | 'resolved').
  List<ActivityEvent> get filteredEvents {
    switch (_filter) {
      case ActivityFilter.active:
        return _allEvents.where((e) => e.isActive).toList();
      case ActivityFilter.resolved:
        return _allEvents.where((e) => e.isResolved).toList();
      case ActivityFilter.all:
        return _allEvents;
    }
  }

  // ── Actions ────────────────────────────────────────────────────────────────

  /// Loads the 3 most-recent events for the home screen widget.
  Future<void> fetchRecentEvents() async {
    _isLoadingRecent = true;
    _recentError = null;
    notifyListeners();
    try {
      final all = await repository.getEvents();
      _hasActiveActivities = all.any((e) => e.isActive);
      
      final sorted = List<ActivityEvent>.from(all);
      sorted.sort((a, b) => b.detectedAt.compareTo(a.detectedAt));
      _recentEvents = sorted.take(3).toList();
    } catch (e) {
      _recentError = e.toString();
    } finally {
      _isLoadingRecent = false;
      notifyListeners();
    }
  }

  /// Fetches all events from the API once and stores them in [_allEvents].
  /// The [filteredEvents] getter then applies client-side filtering.
  Future<void> fetchAllEvents() async {
    _isLoadingAll = true;
    _allError = null;
    notifyListeners();
    try {
      _allEvents = await repository.getEvents();
      _hasActiveActivities = _allEvents.any((e) => e.isActive);
    } catch (e) {
      _allError = e.toString();
    } finally {
      _isLoadingAll = false;
      notifyListeners();
    }
  }

  /// Changes the active filter and notifies listeners.
  /// No extra network call — filtering is done in-memory from [_allEvents].
  void setFilter(ActivityFilter f) {
    if (_filter == f) return;
    _filter = f;
    notifyListeners();
  }

  /// Marks an event as resolved both locally (optimistic update) and in the backend.
  /// Reverts changes in-memory if the backend call fails.
  Future<void> resolveEvent(int id) async {
    final previousEvents = List<ActivityEvent>.from(_allEvents);
    final previousRecentEvents = List<ActivityEvent>.from(_recentEvents);
    final previousHasActive = _hasActiveActivities;

    // Optimistically update status in local lists
    _allEvents = _allEvents.map((e) {
      if (e.id == id) {
        return e.copyWith(status: 'resolved', resolvedAt: DateTime.now());
      }
      return e;
    }).toList();

    _recentEvents = _recentEvents.map((e) {
      if (e.id == id) {
        return e.copyWith(status: 'resolved', resolvedAt: DateTime.now());
      }
      return e;
    }).toList();

    _hasActiveActivities = _allEvents.any((e) => e.isActive) || _recentEvents.any((e) => e.isActive);
    notifyListeners();

    try {
      await repository.resolveEvent(id);
    } catch (e) {
      // Revert if API call fails
      _allEvents = previousEvents;
      _recentEvents = previousRecentEvents;
      _hasActiveActivities = previousHasActive;
      notifyListeners();
      rethrow;
    }
  }
}

