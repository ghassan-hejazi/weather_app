import 'package:flutter_application_1/features/home_screen/binding/home_binding.dart';
import 'package:flutter_application_1/features/home_screen/page/home_page.dart';
import 'package:flutter_application_1/features/search_screen/page/search_page.dart';
import 'package:flutter_application_1/features/splash_screen/image_splash_widget.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

final List<GetPage> pages = <GetPage>[
  GetPage(
    name: AppRoutes.splash,
    page: () => const ImageSplashWidget(),
  ),
  GetPage(
    name: AppRoutes.home,
    page: () => const HomePage(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: AppRoutes.search,
    page: () => const SearchPage(),
    binding: HomeBinding(),
  ),
];
