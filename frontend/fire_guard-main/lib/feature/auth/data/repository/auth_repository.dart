import '../../../../core/services/api_service.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/endpoints.dart';
import '../model/user_model.dart';

class AuthRepository {
  final ApiService apiService;

  AuthRepository(this.apiService);

  Future<UserModel> login({required String username, required String password}) async {
    final response = await apiService.post(Endpoints.login, {
      'username': username,
      'password': password,
    });

    final data = response.data;
    
    // Assuming token might be returned directly in the response or inside a token field
    String? token = data['token'] ?? data['access_token'];
    
    // Assuming user details might be under a 'user' key or at the root
    UserModel user = UserModel.fromJson(data['user'] ?? data);
    
    if (token != null) {
      await CacheHelper.saveData(key: 'token', value: token);
    }
    
    return user;
  }

  Future<UserModel> register({required Map<String, dynamic> userData}) async {
    final response = await apiService.post(Endpoints.register, userData);
    
    final data = response.data;
    String? token = data['token'] ?? data['access_token'];
    UserModel user = UserModel.fromJson(data['user'] ?? data);
    
    if (token != null) {
      await CacheHelper.saveData(key: 'token', value: token);
    }
    
    return user;
  }

  Future<UserModel> getProfile() async {
    final response = await apiService.get(Endpoints.userProfile);
    return UserModel.fromJson(response.data['user'] ?? response.data);
  }

  Future<void> logout() async {
    try {
      await apiService.post(Endpoints.logout, {});
    } catch (e) {
      // Ignore API errors during logout, we still want to remove local token
    } finally {
      await CacheHelper.removeData(key: 'token');
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    await apiService.post(Endpoints.changePassword, {
      'old_password': oldPassword,
      'new_password': newPassword,
      'new_password2': newPassword,
    });
  }
}
