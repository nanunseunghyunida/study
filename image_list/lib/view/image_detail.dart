import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_list/controller/image_detail_controller.dart';
import 'package:image_list/widget/main_container.dart';
import 'package:photo_view/photo_view.dart';

class ImageDetail extends GetView<ImageDetailController> {
  const ImageDetail({super.key});

  @override
  build(BuildContext context) {
    return MainContainer(
      showBottomNavigation: false,
      body: Stack(
        children: [
          PhotoView(
            heroAttributes: PhotoViewHeroAttributes(tag: controller.imageData.imageUrl!),
            imageProvider: NetworkImage(controller.imageData.imageUrl!),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
          ),
          SafeArea(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
