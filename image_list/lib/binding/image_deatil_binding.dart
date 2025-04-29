import 'package:get/get.dart';
import 'package:image_list/controller/image_detail_controller.dart';

class ImageDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ImageDetailController());
  }
}
