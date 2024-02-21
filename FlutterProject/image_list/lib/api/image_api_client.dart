import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ImageApiClient extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = dotenv.get("KAKAO_API_URL");
    httpClient.timeout = const Duration(seconds: 10);
    httpClient.errorSafety = true;

    httpClient.addRequestModifier<FutureOr>((request) async {
      Map<String, String> headers = {
        'Authorization': "KakaoAK ${dotenv.get('KAKAO_API_KEY')}",
      };
      request.headers.addAll(headers);
      return request;
    });
  }
}
