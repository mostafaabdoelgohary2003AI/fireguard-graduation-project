import '../constant/api_constants.dart';
import '../models/event_model.dart';
import 'api_service.dart';

/// All fire-event CRUD operations against the backend.
class EventService {
  EventService._();

  // ── List / filter ─────────────────────────────────────────────────────────

  /// Fetch a list of events.
  /// Optional filters: [status] ('active'|'resolved'|'false_alarm'),
  ///                   [eventType] ('fire'|'smoke'),
  ///                   [cameraId], [zoneId].
  static Future<List<EventModel>> getEvents({
    String? status,
    String? eventType,
    int? cameraId,
    int? zoneId,
  }) async {
    final params = <String, dynamic>{};
    if (status    != null) params['status'] = status;
    if (eventType != null) params['type']   = eventType;
    if (cameraId  != null) params['camera'] = cameraId;
    if (zoneId    != null) params['zone']   = zoneId;

    final response = await ApiService.get(
      ApiConstants.events,
      params: params.isNotEmpty ? params : null,
    );

    final list = response.data as List<dynamic>;
    return list
        .map((e) => EventModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ── Active event ─────────────────────────────────────────────────────────

  /// Returns the most recent active event, or null if none exists.
  static Future<EventModel?> getActiveEvent() async {
    final response = await ApiService.get(ApiConstants.activeEvent);
    final data = response.data as Map<String, dynamic>;

    if (data['active'] == true && data['event'] != null) {
      return EventModel.fromJson(data['event'] as Map<String, dynamic>);
    }
    return null;
  }

  // ── Stats ─────────────────────────────────────────────────────────────────

  static Future<Map<String, int>> getStats() async {
    final response = await ApiService.get(ApiConstants.eventStats);
    final raw = response.data as Map<String, dynamic>;
    return raw.map((k, v) => MapEntry(k, (v as num).toInt()));
  }

  // ── Status updates ────────────────────────────────────────────────────────

  static Future<EventModel> resolveEvent(int id) async {
    final response = await ApiService.patch('${ApiConstants.events}$id/resolve/');
    final data = response.data as Map<String, dynamic>;
    return EventModel.fromJson(data['event'] as Map<String, dynamic>);
  }

  static Future<EventModel> markFalseAlarm(int id) async {
    final response =
        await ApiService.patch('${ApiConstants.events}$id/false-alarm/');
    final data = response.data as Map<String, dynamic>;
    return EventModel.fromJson(data['event'] as Map<String, dynamic>);
  }
}
