import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ImageApiClient extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = dotenv.get("KAKAO_API_URL");
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.errorSafety = true;
    httpClient.maxAuthRetries = 3;

    httpClient.addRequestModifier<FutureOr>((request) async {
      Map<String, String> headers = {
        'Authorization': "KakaoAK ${dotenv.get('KAKAO_API_KEY')}",
        'Accept': 'application/json',
      };
      request.headers.addAll(headers);
      return request;
    });

    httpClient.addResponseModifier<FutureOr>((request, response) async {
      if (response.statusCode == null || response.statusCode! >= 400) {
        throw Exception('API 요청 실패: ${response.statusCode}');
      }
      return response;
    });
  }
}
