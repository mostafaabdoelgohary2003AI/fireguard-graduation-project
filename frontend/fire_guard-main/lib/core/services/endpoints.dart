class Endpoints {
  static const String baseUrl = 'https://bodareda0001.pythonanywhere.com/';
  static const String login = 'api/auth/login/';
  static const String register = 'api/auth/register/';
  static const String userProfile = 'api/auth/profile/';
  static const String logout = 'api/auth/logout/';
  static const String changePassword = 'api/auth/change-password/';

  // AI service — set at build time:
  //   flutter run --dart-define=AI_BASE_URL=http://192.168.1.x:8001
  static const String aiBaseUrl = String.fromEnvironment(
    'AI_BASE_URL',
    defaultValue: 'http://10.0.2.2:8001',
  );
  static const String predict = '/predict';
}
