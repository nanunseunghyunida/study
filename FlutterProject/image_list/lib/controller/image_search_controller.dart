import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_list/api/model/image_search_document.dart';
import 'package:image_list/api/model/image_search_response.dart';
import 'package:image_list/api/repository/image_search_repository.dart';
import 'package:image_list/util/global_util.dart';

class ImageSearchController extends GetxController {
  static ImageSearchController get to => Get.find();

  final storage = GetStorage();

  final ImageSearchRepository repository = Get.find();

  TextEditingController textController = TextEditingController();
  FocusNode textFocusNode = FocusNode();
  late ScrollController scrollController;

  RxList<ImageSearchDocument> imageList = <ImageSearchDocument>[].obs;

  // 하단 스크롤 도착했는지 여부
  RxBool isBottom = false.obs;
  // 상단에 도달했는지
  RxBool isTop = false.obs;
  // 페이징 넘버
  RxInt nextPage = 1.obs;
  // 호출당 출력 갯수
  int limit = 30;
  // 로딩중인지
  RxBool isLoading = false.obs;
  // 마지막 페이지인지
  RxBool isLastPage = true.obs;
  // 검색어 저장 (for pagination)
  RxString keyword = ''.obs;
  // 결과 문구
  RxString resultText = ''.obs;

  searchKeyword({page = 1}) async {
    textFocusNode.unfocus();

    Map<String, dynamic> params = {
      'query': keyword.value,
      'page': page.toString(),
      'size': limit.toString(),
    };

    isLoading.value = true;

    ImageSearchResponse response = await repository.searchImage(params);

    if (page == 1) imageList.clear();

    if (response.meta != null) {
      isLastPage.value = response.meta!.isEnd!;
      var list = response.documents!;

      Iterable<String> savedImages = storage.getKeys();

      for (var item in savedImages) {
        list.firstWhereOrNull((element) => element.docUrl == item)?.isFavorite = true;
      }

      imageList.addAll(list);
    } else {
      isLastPage.value = true;
      nextPage.value = 1;
    }

    if (imageList.isEmpty) {
      resultText.value = '검색결과가 없습니다.';
    } else {
      resultText.value = '';
    }

    isLoading.value = false;
  }

  favoriteUpdate(ImageSearchDocument data) async {
    data.isFavorite = !data.isFavorite!;

    if (data.isFavorite!) {
      if (!Get.isSnackbarOpen) {
        Get.rawSnackbar(
          duration: const Duration(milliseconds: 2000),
          animationDuration: const Duration(milliseconds: 500),
          backgroundColor: Colors.black.withOpacity(0.8),
          borderRadius: 10,
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          messageText: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, color: Colors.red, size: 30),
              SizedBox(width: 8),
              Text(
                '즐겨찾기에 등록되었습니다.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }
      // 좋아요 리스트에 추가
      await storage.write(data.docUrl!, data);
    } else {
      // 좋아요 리스트에서 삭제
      await storage.remove(data.docUrl!);
    }
    imageList.refresh();
  }

  @override
  void onReady() {
    // 스크롤 무한스크롤
    scrollController.addListener(() {
      double maxPosition = scrollController.position.maxScrollExtent;
      double currentPosition = scrollController.position.pixels;
      double difference = 70.0;
      isTop.value = GlobalUtil().topScrollCheck(maxPosition, currentPosition);
      isBottom.value = GlobalUtil().bottomScrollCheck(maxPosition, currentPosition, difference);

      // 상단 체크는 false이고 하단여부가 true이고 로딩중이 아니고 마지막 페이지가 아니면
      if (!isTop.value && isBottom.value && !isLoading.value && !isLastPage.value) {
        // api 호출 한다 - paramter가 없으면 1페이지 호출
        searchKeyword(page: nextPage.value + 1);
      }
    });

    super.onReady();
  }
}
