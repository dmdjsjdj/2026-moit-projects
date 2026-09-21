import 'package:dio/dio.dart';
import 'api_client.dart';

class AuthApi {
  Future<Response> login({
    required String loginId,
    required String password,
    required String deviceId,
  }) {
    return ApiClient.dio.post(
      '/api/members/login',
      data: {
        'loginId': loginId,
        'password': password,
        'deviceId': deviceId,
      },
      options: Options(
        headers: {
          'X-Device-Id': deviceId,
        },
      ),
    );
  }

  Future<Response> getMyInfo() {
    return ApiClient.dio.get('/api/members/me');
  }
}