import 'package:dio/dio.dart';
import '../error/exceptions.dart';
import 'cache_helper.dart';
import 'endpoints.dart';

class ApiService {
  late final Dio dio;

  ApiService() {
    final baseOptions = BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json', 'Accept-Language': 'en'},
    );
    dio = Dio(baseOptions);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = CacheHelper.getData(key: 'token');
          if (token != null) {
            options.headers['Authorization'] = 'Token $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    try {
      return await dio.get(path, queryParameters: query);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<Response> post(String path, Map<String, dynamic>? data) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<Response> patch(String path, Map<String, dynamic>? data) async {
    try {
      return await dio.patch(path, data: data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await dio.delete(path);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<Response> postMultipart(String path, FormData data) async {
    try {
      return await dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  ServerException _handleDioError(DioException error) {
    if (error.response != null) {
      final data = error.response!.data;
      if (data is Map<String, dynamic>) {
        // Try common error keys from backend
        if (data.containsKey('message')) {
          return ServerException(data['message'].toString());
        } else if (data.containsKey('error')) {
          return ServerException(data['error'].toString());
        } else if (data.containsKey('detail')) {
          return ServerException(data['detail'].toString());
        } else if (data.isNotEmpty) {
          // In Django REST Framework, 400 errors are often field-level: {'email': ['Email already exists']}
          final firstKey = data.keys.first;
          final firstError = data[firstKey];
          if (firstError is List && firstError.isNotEmpty) {
            return ServerException('$firstKey: ${firstError.first}');
          } else {
            return ServerException('$firstKey: $firstError');
          }
        }
      }
      return ServerException('Server error occurred with status code: ${error.response?.statusCode}');
    } else {
      return ServerException('Network error or connection timeout');
    }
  }
}
