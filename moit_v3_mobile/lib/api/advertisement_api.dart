import 'package:dio/dio.dart';

import '../models/advertisement.dart';
import 'api_client.dart';

class AdvertisementApi {
  Future<Advertisement?> getTopAdvertisement({
    required String position,
  }) async {
    final response = await ApiClient.dio.get(
      '/api/advertisement/top',
      queryParameters: {
        'position': position,
      },
    );

    // 노출할 광고가 없는 경우
    if (response.statusCode == 204 || response.data == null) {
      return null;
    }

    print('===== 광고 응답 =====');
    print(response.data);

    return Advertisement.fromJson(
      Map<String, dynamic>.from(response.data),
    );
  }

  Future<void> increaseImpression({
    required int adId,
    required String position,
  }) async {
    await ApiClient.dio.post(
      '/api/advertisement/impression',
      queryParameters: {
        'adId': adId,
        'position': position,
      },
    );
  }

  Future<void> increaseClick({
    required int adId,
    required String position,
  }) async {
    await ApiClient.dio.post(
      '/api/advertisement/click',
      queryParameters: {
        'adId': adId,
        'position': position,
      },
    );
  }
}