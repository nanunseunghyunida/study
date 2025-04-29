import 'package:get/get.dart';
import 'package:image_list/api/repository/image_search_repository.dart';
import 'package:image_list/controller/image_search_controller.dart';

class ImageSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ImageSearchRepository(), permanent: true);
    Get.put(ImageSearchController(), permanent: true);
  }
}
