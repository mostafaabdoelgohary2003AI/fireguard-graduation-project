import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/models/user_model.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/notification_service.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthProvider extends ChangeNotifier {
  AuthStatus _status    = AuthStatus.unknown;
  UserModel? _user;
  bool       _isLoading = false;
  String?    _error;

  // Password-field visibility — used by login / signup forms.
  bool _obscurePassword        = true;
  bool _obscureConfirmPassword = true;

  AuthStatus get status               => _status;
  UserModel? get user                 => _user;
  bool       get isLoading            => _isLoading;
  String?    get error                => _error;
  bool       get isAuthenticated      => _status == AuthStatus.authenticated;
  bool       get obscurePassword      => _obscurePassword;
  bool       get obscureConfirmPassword => _obscureConfirmPassword;

  // ── Init ─────────────────────────────────────────────────────────────────

  Future<void> checkAuthStatus() async {
    final loggedIn = await AuthService.isLoggedIn();
    _status = loggedIn ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    notifyListeners();
  }

  // ── Login ─────────────────────────────────────────────────────────────────

  Future<bool> login(String username, String password) async {
    _setLoading(true);
    try {
      final data = await AuthService.login(username.trim(), password);
      _user   = UserModel.fromJson(data['user'] as Map<String, dynamic>);
      _status = AuthStatus.authenticated;
      _error  = null;

      // Register FCM token with the backend after successful login.
      await NotificationService.registerFcmToken();

      return true;
    } on DioException catch (e) {
      _error = parseApiError(e);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ── Register ──────────────────────────────────────────────────────────────

  Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      final data = await AuthService.register(
        username: username.trim(),
        email:    email.trim(),
        password: password,
      );
      _user   = UserModel.fromJson(data['user'] as Map<String, dynamic>);
      _status = AuthStatus.authenticated;
      _error  = null;

      // Register FCM token with the backend after successful registration.
      await NotificationService.registerFcmToken();

      return true;
    } on DioException catch (e) {
      _error = parseApiError(e);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // ── Logout ────────────────────────────────────────────────────────────────

  Future<void> logout() async {
    _setLoading(true);
    try {
      await NotificationService.unregisterFcmToken();
      await AuthService.logout();
    } catch (_) {} finally {
      _user   = null;
      _status = AuthStatus.unauthenticated;
      _error  = null;
      _setLoading(false);
    }
  }

  // ── Password visibility helpers ──────────────────────────────────────────

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void resetVisibility() {
    _obscurePassword        = true;
    _obscureConfirmPassword = true;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // ── Private ───────────────────────────────────────────────────────────────

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
