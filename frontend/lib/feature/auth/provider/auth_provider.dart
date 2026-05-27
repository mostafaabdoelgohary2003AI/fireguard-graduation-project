import 'package:flutter/material.dart';
import '../../../../core/services/cache_helper.dart';
import '../data/model/user_model.dart';
import '../data/repository/auth_repository.dart';
import '../../../../core/services/firebase_notifications.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthProvider({required this.authRepository});

  UserModel? _user;
  AuthStatus _status = AuthStatus.initial;
  String? _errorMessage;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  UserModel? get user => _user;
  
  // Role-Based Access Control getters
  bool get isAdmin => _user?.isStuff == true;
  bool get isMember => _user?.isStuff == false;
  
  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == AuthStatus.loading;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;

  Future<void> login({required String email, required String password}) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await authRepository.login(username: email, password: password);
      _status = AuthStatus.authenticated;
      FirebaseNotifications().sendTokenToBackend();
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> register({required Map<String, dynamic> userData}) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await authRepository.register(userData: userData);
      _status = AuthStatus.authenticated;
      FirebaseNotifications().sendTokenToBackend();
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

  Future<void> getProfile() async {
    final token = CacheHelper.getData(key: 'token');
    if (token == null) {
      _status = AuthStatus.unauthenticated;
      notifyListeners();
      return;
    }

    try {
      _user = await authRepository.getProfile();
      _status = AuthStatus.authenticated;
      FirebaseNotifications().sendTokenToBackend();
    } catch (e) {
      _status = AuthStatus.unauthenticated;
      // If profile fails, token might be invalid
      await authRepository.logout();
    } finally {
      notifyListeners();
    }
  }

  Future<bool> updateProfile(int id, Map<String, dynamic> data) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await authRepository.updateProfile(id, data);
      _status = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AuthStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  void resetTextStates() {
    _obscurePassword = true;
    _obscureConfirmPassword = true;
    _errorMessage = null;
    notifyListeners();
  }
}
