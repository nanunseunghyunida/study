import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_list/api/image_api_client.dart';
import 'package:image_list/routes/pages.dart';

void main() async {
  // .env init
  await dotenv.load(fileName: "assets/config/.env");

  // image api client global setting
  Get.put(ImageApiClient());

  // local storage init
  await GetStorage.init();

  runApp(const ImageSearchApp());
}

class ImageSearchApp extends StatelessWidget {
  const ImageSearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: Pages.routes,
      initialRoute: Routes.imageSearch,
    );
  }
}
