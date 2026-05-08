import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constant/api_constants.dart';
import '../models/user_model.dart';
import 'api_service.dart';

/// Handles token persistence and auth-related API calls.
///
/// The auth token is stored in the device's secure keystore —
/// it survives app restarts but is cleared on logout.
class AuthService {
  AuthService._();

  static const _storage  = FlutterSecureStorage();
  static const _tokenKey = 'fg_auth_token';

  // ── Token management ─────────────────────────────────────────────────────

  static Future<String?> getToken() => _storage.read(key: _tokenKey);

  static Future<void> saveToken(String token) =>
      _storage.write(key: _tokenKey, value: token);

  static Future<void> clearToken() => _storage.delete(key: _tokenKey);

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // ── API calls ─────────────────────────────────────────────────────────────

  /// Returns a map with 'token' and 'user' keys on success.
  /// Throws [DioException] on failure (parsed by [parseApiError]).
  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    final response = await ApiService.post(
      ApiConstants.login,
      data: {'username': username, 'password': password},
    );
    final data = response.data as Map<String, dynamic>;
    await saveToken(data['token'] as String);
    return data;
  }

  static Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await ApiService.post(
      ApiConstants.register,
      data: {'username': username, 'email': email, 'password': password},
    );
    final data = response.data as Map<String, dynamic>;
    await saveToken(data['token'] as String);
    return data;
  }

  static Future<void> logout() async {
    try {
      await ApiService.post(ApiConstants.logout);
    } catch (_) {
      // Best-effort server logout; always clear the local token.
    }
    await clearToken();
  }

  static Future<UserModel> getProfile() async {
    final response = await ApiService.get(ApiConstants.profile);
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }
}
