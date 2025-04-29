import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_list/api/model/image_search_document.dart';

class ImageFavoriteController extends GetxController {
  static ImageFavoriteController get to => Get.find();

  final storage = GetStorage();

  late ScrollController scrollController;

  RxList<ImageSearchDocument> favoriteList = <ImageSearchDocument>[].obs;

  // 로딩중인지
  RxBool isLoading = false.obs;
  // 결과 문구
  RxString resultText = ''.obs;

  loadFavorite() async {
    isLoading.value = true;

    favoriteList.clear();

    Iterable<String> savedKeys = storage.getKeys();

    if (savedKeys.isEmpty) {
      resultText.value = '좋아요한 사진이 없어요!';
    } else {
      for (var key in savedKeys) {
        var data = await storage.read(key);

        if (data.runtimeType != ImageSearchDocument) {
          data = ImageSearchDocument.fromJson(data);
        }

        favoriteList.insert(0, data);
      }

      favoriteList.refresh();
    }

    isLoading.value = false;
  }

  favoriteUpdate(ImageSearchDocument data) async {
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
        duration: const Duration(milliseconds: 2000),
        animationDuration: const Duration(milliseconds: 500),
        backgroundColor: Colors.black.withValues(alpha: 0.8),
        borderRadius: 10,
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        messageText: const Center(
          child: Text(
            '즐겨찾기에서 삭제되었습니다.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    // 좋아요 리스트에서 삭제
    await storage.remove(data.docUrl!);
    favoriteList.remove(favoriteList.firstWhereOrNull((element) => element.docUrl == data.docUrl));
    favoriteList.refresh();
  }

  @override
  void onInit() {
    loadFavorite();

    super.onInit();
  }
}
