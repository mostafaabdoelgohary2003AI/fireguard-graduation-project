import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constant/api_constants.dart';
import 'auth_service.dart';

/// Singleton Dio client.
///
/// Call [ApiService.initialize()] once from main() before runApp().
/// All requests automatically attach the stored auth token.
/// 401 responses automatically clear the token (caller must redirect to login).
class ApiService {
  ApiService._();

  static final Dio _dio = Dio();
  static bool _initialized = false;

  static void initialize() {
    if (_initialized) return;

    _dio.options = BaseOptions(
      baseUrl:        ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      headers: {'Content-Type': 'application/json'},
    );

    _dio.interceptors.add(_AuthInterceptor());

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody:  true,
        responseBody: true,
        logPrint:     (o) => debugPrint(o.toString()),
      ));
    }

    _initialized = true;
  }

  // ── Public helpers ────────────────────────────────────────────────────────

  static Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? params,
  }) =>
      _dio.get<T>(path, queryParameters: params);

  static Future<Response<T>> post<T>(
    String path, {
    dynamic data,
  }) =>
      _dio.post<T>(path, data: data);

  static Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
  }) =>
      _dio.patch<T>(path, data: data);

  static Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
  }) =>
      _dio.delete<T>(path, data: data);
}

// ── Auth interceptor ────────────────────────────────────────────────────────

class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await AuthService.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Token $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Silently clear the stored token; the caller / provider handles navigation.
      AuthService.clearToken();
    }
    handler.next(err);
  }
}

/// Parses a [DioException] into a user-readable string.
String parseApiError(DioException e) {
  final data = e.response?.data;
  if (data is Map) {
    // DRF sends {"error": "..."} or {"detail": "..."}
    return (data['error'] ?? data['detail'] ?? data.values.first)
        .toString();
  }
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    return 'Connection timed out. Check your network.';
  }
  if (e.type == DioExceptionType.connectionError) {
    return 'Cannot reach the server. Check your internet.';
  }
  return 'An unexpected error occurred.';
}
