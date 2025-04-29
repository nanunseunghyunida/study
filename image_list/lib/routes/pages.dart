import 'package:get/route_manager.dart';
import 'package:image_list/binding/image_deatil_binding.dart';
import 'package:image_list/binding/image_favorite_binding.dart';
import 'package:image_list/binding/image_search_binding.dart';
import 'package:image_list/view/image_detail.dart';
import 'package:image_list/view/image_favorite.dart';
import 'package:image_list/view/image_search.dart';

part 'routes.dart';

class Pages {
  static final routes = [
    GetPage(
      name: Routes.imageSearch,
      page: () => const ImageSearch(),
      binding: ImageSearchBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.imageDetail,
      page: () => const ImageDetail(),
      binding: ImageDetailBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: Routes.imageFavorite,
      page: () => const ImageFavorite(),
      binding: ImageFavoriteBinding(),
      transition: Transition.noTransition,
    ),
  ];
}
