import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:image_list/api/model/image_search_document.dart';
import 'package:image_list/controller/image_favorite_controller.dart';
import 'package:image_list/routes/pages.dart';
import 'package:image_list/widget/main_container.dart';

class ImageFavorite extends GetView<ImageFavoriteController> {
  const ImageFavorite({super.key});

  @override
  build(BuildContext context) {
    controller.scrollController = ScrollController();

    return MainContainer(
      showBottomNavigation: true,
      menuIndex: 1,
      scrollController: controller.scrollController,
      body: SafeArea(
        child: Obx(() => Stack(
              children: [
                CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: controller.scrollController,
                  slivers: [
                    controller.favoriteList.isEmpty
                        ? SliverFillRemaining(
                            child: Center(
                              child: Text(controller.resultText.value),
                            ),
                          )
                        : SliverMasonryGrid.count(
                            childCount: controller.favoriteList.length,
                            crossAxisCount: 2,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                            itemBuilder: (context, index) {
                              var data = controller.favoriteList[index];
                              return ImageItem(data: data, controller: controller);
                            },
                          ),
                  ],
                ),
                controller.isLoading.value ? const Center(child: CircularProgressIndicator(strokeWidth: 2)) : Container()
              ],
            )),
      ),
    );
  }
}

class ImageItem extends StatelessWidget {
  const ImageItem({
    super.key,
    required this.data,
    required this.controller,
  });

  final ImageSearchDocument data;
  final ImageFavoriteController controller;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.imageDetail, arguments: {'data': data});
            },
            child: Hero(
              tag: data.imageUrl!,
              child: Image.network(
                data.imageUrl!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: 120,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 120,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 30,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '이미지 로딩 실패',
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            right: 3,
            top: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => controller.favoriteUpdate(data),
                child: Icon(
                  data.isFavorite! ? Icons.favorite : Icons.favorite_border,
                  color: data.isFavorite! ? Colors.red : Colors.white.withValues(alpha: 100),
                  shadows: [
                    Shadow(color: Colors.black.withValues(alpha: 200), offset: const Offset(2, 2)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
