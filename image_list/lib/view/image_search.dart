import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:image_list/controller/image_search_controller.dart';
import 'package:image_list/routes/pages.dart';
import 'package:image_list/widget/main_container.dart';

class ImageSearch extends GetView<ImageSearchController> {
  const ImageSearch({super.key});

  @override
  build(BuildContext context) {
    controller.scrollController = ScrollController();

    return MainContainer(
      showBottomNavigation: true,
      menuIndex: 0,
      scrollController: controller.scrollController,
      body: SafeArea(
        child: Obx(() => Stack(
              children: [
                RefreshIndicator(
                  onRefresh: () async => controller.doRefresh(),
                  child: CustomScrollView(
                    controller: controller.scrollController,
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        floating: true,
                        snap: true,
                        title: TextFormField(
                          controller: controller.textController,
                          maxLength: 30,
                          focusNode: controller.textFocusNode,
                          onFieldSubmitted: (value) {
                            controller.keyword.value = value;
                            controller.searchKeyword();
                          },
                          decoration: InputDecoration(
                            hintText: '검색어를 입력해주세요.',
                            counterText: '',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            suffixIcon: InkWell(
                              borderRadius: const BorderRadius.all(Radius.circular(30)),
                              onTap: () {
                                controller.keyword.value = controller.textController.text;
                                controller.searchKeyword();
                              },
                              child: const Icon(Icons.search_rounded, size: 24),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                          ),
                        ),
                      ),
                      controller.imageList.isEmpty
                          ? SliverFillRemaining(
                              child: Center(
                                child: Text(controller.resultText.value),
                              ),
                            )
                          : SliverMasonryGrid.count(
                              childCount: controller.imageList.length,
                              crossAxisCount: 2,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                              itemBuilder: (context, index) {
                                var data = controller.imageList[index];
                                return ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.textFocusNode.unfocus();
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
                                      data.displaySitename == ''
                                          ? Container()
                                          : Positioned(
                                              bottom: 0,
                                              child: Container(
                                                color: Colors.black.withValues(alpha: 150),
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                child: Text(
                                                  data.displaySitename!,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
                controller.isLoading.value ? const Center(child: CircularProgressIndicator(strokeWidth: 2)) : Container()
              ],
            )),
      ),
    );
  }
}
