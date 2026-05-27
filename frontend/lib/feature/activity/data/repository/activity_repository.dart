import 'package:fire_gaurd/core/models/activity_model.dart';
import 'package:fire_gaurd/core/services/api_service.dart';
import 'package:fire_gaurd/core/services/endpoints.dart';

class ActivityRepository {
  final ApiService apiService;

  ActivityRepository(this.apiService);

  /// Fetches all events from [api/events/]. Client-side filtering is applied
  /// in the provider based on the [ActivityEvent.status] field.
  Future<List<ActivityEvent>> getEvents() async {
    final response = await apiService.get(Endpoints.recentActivity);
    final List data = response.data is List ? response.data : [];
    return data.map((e) => ActivityEvent.fromJson(e)).toList();
  }

  /// Fetches only the latest [limit] events (no filter) for the home screen.
  Future<List<ActivityEvent>> getRecentEvents({int limit = 3}) async {
    final all = await getEvents();
    // Sort descending by detectedAt and take the latest
    all.sort((a, b) => b.detectedAt.compareTo(a.detectedAt));
    return all.take(limit).toList();
  }

  /// Resolves an event in the backend by making a PATCH request.
  Future<void> resolveEvent(int id) async {
    await apiService.patch(Endpoints.resolveEvent(id), null);
  }
}
