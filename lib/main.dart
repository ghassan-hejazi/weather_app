import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home_screen/binding/home_binding.dart';
import 'package:flutter_application_1/features/home_screen/controllers/home_controller.dart';
import 'package:flutter_application_1/core/localization/localizations.dart';
import 'package:flutter_application_1/features/splash_screen/image_splash_widget.dart';
import 'package:flutter_application_1/utils/routing/app_routes.dart';
import 'package:flutter_application_1/utils/routing/pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.splash,
            theme: GetStorage().read('themeData') == 'dark'
                ? ThemeData.dark(useMaterial3: true)
                : ThemeData.light(useMaterial3: true),
            locale: controller.getlocale(),
            translations: MyLocale(),
            getPages: pages,
            initialBinding: HomeBinding(),
            home: const ImageSplashWidget(),
          );
        });
  }
}
