import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/style/app_sizes.dart';
import 'package:get/get.dart';

class ImageSplashWidget extends StatelessWidget {
  const ImageSplashWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed('/home');
    });
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          width: AppSizes.r170,
        ),
      ),
    );
  }
}
