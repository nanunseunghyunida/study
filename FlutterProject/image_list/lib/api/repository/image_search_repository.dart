import 'package:get/get.dart';
import 'package:image_list/api/image_api_client.dart';
import 'package:image_list/api/model/image_search_response.dart';

class ImageSearchRepository {
  static ImageSearchRepository get to => Get.find();

  final ImageApiClient apiClient = Get.find();

  searchImage(Map<String, dynamic> params) async {
    Response response = await apiClient.get("/v2/search/image", query: params);
    return ImageSearchResponse.fromJson(response.body);
  }
}
