import 'package:get/get.dart';
import 'package:image_list/controller/image_favorite_controller.dart';

class ImageFavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImageFavoriteController());
  }
}
