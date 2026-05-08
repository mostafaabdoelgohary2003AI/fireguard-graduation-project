/// Central registry for all backend API endpoints.
/// Base URL is injected at build time:
///   flutter run --dart-define=BACKEND_URL=https://bodareda0001.pythonanywhere.com
class ApiConstants {
  ApiConstants._();

  static const String baseUrl = String.fromEnvironment(
    'BACKEND_URL',
    defaultValue: 'https://bodareda0001.pythonanywhere.com',
  );

  // ── Auth ──────────────────────────────────────────────────────────────────
  static const String login          = '/api/auth/login/';
  static const String register       = '/api/auth/register/';
  static const String logout         = '/api/auth/logout/';
  static const String profile        = '/api/auth/profile/';
  static const String changePassword = '/api/auth/change-password/';

  // ── Events ────────────────────────────────────────────────────────────────
  static const String events      = '/api/events/';
  static const String activeEvent = '/api/events/active/';
  static const String eventStats  = '/api/events/stats/';

  // ── Cameras ───────────────────────────────────────────────────────────────
  static const String cameras = '/api/cameras/';

  // ── Notifications ─────────────────────────────────────────────────────────
  static const String registerDevice   = '/api/notifications/register-device/';
  static const String unregisterDevice = '/api/notifications/unregister-device/';
  static const String testPush         = '/api/notifications/test-push/';

  // ── Timeouts ──────────────────────────────────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
