import 'package:flutter/material.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/services/api_service.dart';
import '../data/model/user_model.dart';
import '../data/repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository(ApiService());

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool _isLoading = false;
  String? _errorMessage;
  UserModel? _user;

  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get user => _user;

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
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    _setLoading(true);
    try {
      _user = await authRepository.login(username: username, password: password);
      _errorMessage = null;
      _setLoading(false);
      return true;
    } on ServerException catch (e) {
      _errorMessage = e.message;
      _setLoading(false);
      return false;
    } catch (e) {
      _errorMessage = "An unexpected error occurred.";
      _setLoading(false);
      return false;
    }
  }

  Future<bool> register(Map<String, dynamic> userData) async {
    _setLoading(true);
    try {
      _user = await authRepository.register(userData: userData);
      _errorMessage = null;
      _setLoading(false);
      return true;
    } on ServerException catch (e) {
      _errorMessage = e.message;
      _setLoading(false);
      return false;
    } catch (e) {
      _errorMessage = "An unexpected error occurred.";
      _setLoading(false);
      return false;
    }
  }

  Future<void> logout() async {
    _setLoading(true);
    try {
      await authRepository.logout();
      _user = null;
    } catch (e) {
      // Ignore logout errors
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
