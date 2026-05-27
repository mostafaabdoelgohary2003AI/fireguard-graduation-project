class Endpoints {
  static const String baseUrl = 'https://bodareda0001.pythonanywhere.com/';
  static const String login = 'api/auth/login/';
  static const String register = 'api/auth/register/';
  static const String userProfile = 'api/auth/profile/';
  static const String logout = 'api/auth/logout/';
  static const String changePassword = 'api/auth/change-password/';

  static const String addCamera = 'api/cameras/cameras/';
  static const String getCameras = 'api/cameras/cameras/';
  static const String getAllCameras = 'api/cameras/stats/';
  static const String updateCamera = 'api/cameras/cameras/';
  static const String deleteCamera = 'api/cameras/cameras/';
  static const String recentActivity = 'api/events/';
  static String resolveEvent(int id) => 'api/events/$id/resolve/';
  static const String addZone = 'api/cameras/zones/';
  static const String getZones = 'api/cameras/zones/';
  static const String updateZone = 'api/cameras/zones/';
  static const String deleteZone = 'api/cameras/zones/';

  static const String testPushNotification =
      'api/notifications/register-device/';
}
