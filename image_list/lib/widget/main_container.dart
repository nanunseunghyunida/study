import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_list/routes/pages.dart';

class MainContainer extends StatelessWidget {
  final Widget body;
  final bool showBottomNavigation;
  final int? menuIndex;
  final ScrollController? scrollController;

  final List<Map<String, dynamic>> menuList = [
    {
      'index': 0,
      'label': 'Search',
      'icon': Icons.search_rounded,
      'route': Routes.imageSearch,
    },
    {
      'index': 1,
      'label': 'Favorite',
      'icon': Icons.favorite_border_rounded,
      'route': Routes.imageFavorite,
    },
  ];

  MainContainer({
    super.key,
    required this.body,
    required this.showBottomNavigation,
    this.menuIndex,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    var isScrolling = false;

    return Scaffold(
      bottomNavigationBar: showBottomNavigation
          ? BottomAppBar(
              height: 60,
              elevation: 0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: menuList
                      .asMap()
                      .entries
                      .map(
                        (item) => SizedBox(
                          height: 50,
                          width: (Get.width - 40) / 2,
                          child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              // 동일한 페이지 클릭 시 상단 이동
                              if (menuIndex == item.key) {
                                if (scrollController != null) {
                                  if (!isScrolling) {
                                    isScrolling = true;
                                    scrollController!
                                        .animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeIn)
                                        .then((_) => isScrolling = false);
                                  }
                                }
                                return;
                              }
                              Get.offAllNamed(item.value["route"]);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  item.value['icon'],
                                  color: menuIndex == item.key ? Theme.of(context).primaryColor : Colors.grey,
                                  size: 24,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${item.value['label']}',
                                  style: TextStyle(
                                    color: menuIndex == item.key ? Theme.of(context).primaryColor : Colors.grey,
                                    fontSize: 12,
                                    fontWeight: menuIndex == item.key ? FontWeight.bold : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList()),
            )
          : null,
      body: body,
    );
  }
}
