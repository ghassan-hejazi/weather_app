// ignore_for_file: avoid_print

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/style/app_colors.dart';
import 'package:flutter_application_1/core/style/app_sizes.dart';
import 'package:flutter_application_1/core/widgets/class_cities.dart';
import 'package:flutter_application_1/features/home_screen/controllers/home_controller.dart';
import 'package:get/get.dart';

class SearchPage extends GetView<HomeController> {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: AppSizes.r0,
      ),
      body: ListView(
          padding: EdgeInsetsDirectional.only(
            start: AppSizes.r16,
            end: AppSizes.r16,
            top: AppSizes.r16,
          ),
          children: [
            CustomSearchableDropDown(
              menuHeight: AppSizes.r400,
              items: ClassCities.cities,
              label: 'citys'.tr,
              multiSelectTag: 'Names',
              primaryColor: AppColors.blue,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.r8),
                border: Border.all(
                  width: AppSizes.r0,
                  color: AppColors.blue,
                ),
              ),
              prefixIcon: Padding(
                padding: EdgeInsetsDirectional.all(AppSizes.r2),
                child: Icon(
                  Icons.search,
                  color: AppColors.blue,
                ),
              ),
              dropDownMenuItems: ClassCities.cities.map((item) {
                return item['name'];
              }).toList(),
              onChanged: (value) async {
                controller.updateLat(double.parse(value['lat']));
                controller.updateLon(double.parse(value['lng']));
                Get.back();
              },
            ),
          ]),
    );
  }
}
