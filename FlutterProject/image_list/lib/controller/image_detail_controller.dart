import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_list/api/model/image_search_document.dart';

class ImageDetailController extends GetxController {
  static ImageDetailController get to => Get.find();

  final storage = GetStorage();

  ImageSearchDocument imageData = ImageSearchDocument();

  @override
  void onInit() {
    imageData = Get.arguments['data'];

    super.onInit();
  }
}
