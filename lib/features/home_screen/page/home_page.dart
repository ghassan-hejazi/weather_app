// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/style/app_colors.dart';
import 'package:flutter_application_1/core/style/app_sizes.dart';
import 'package:flutter_application_1/core/widgets/internet_widget.dart';
import 'package:flutter_application_1/core/widgets/row_widget.dart';
import 'package:flutter_application_1/core/widgets/row_widget_two.dart';
import 'package:flutter_application_1/core/widgets/sized_box.dart';
import 'package:flutter_application_1/core/widgets/text_widget.dart';
import 'package:flutter_application_1/features/home_screen/controllers/home_controller.dart';
import 'package:flutter_application_1/model/class_data_weather.dart';
import 'package:flutter_application_1/model/class_five_day_data.dart';
import 'package:flutter_application_1/features/search_screen/page/search_page.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () => controller.willPopScope(context),
        child: Scaffold(
          appBar: AppBar(
            elevation: AppSizes.r0,
            backgroundColor: AppColors.transparent,
            actions: [
              Padding(
                padding: EdgeInsetsDirectional.all(AppSizes.r8),
                child: IconButton(
                  onPressed: () {
                    Get.to(
                      const SearchPage(),
                      transition: Transition.cupertinoDialog,
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    size: AppSizes.r28,
                  ),
                ),
              ),
            ],
          ),
          drawer: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: AppSizes.r16),
            child: SizedBox(
              height: AppSizes.r200,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grey700,
                  borderRadius: BorderRadius.circular(AppSizes.r10),
                ),
                width: AppSizes.r75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.showMyDialog();
                      },
                      icon: Icon(
                        Icons.location_pin,
                        color: AppColors.black,
                        size: AppSizes.r28,
                      ),
                    ),
                    AppSizes.r16.ph,
                    PopupMenuButton(
                      icon: Icon(
                        Icons.settings_brightness,
                        color: AppColors.black,
                        size: AppSizes.r28,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {
                            controller.getThemeDatadark();
                          },
                          value: 1,
                          child: RowWidget(
                            text: 'dark'.tr,
                            icon: Icons.dark_mode,
                          ),
                        ),
                        PopupMenuItem(
                            onTap: () {
                              controller.getThemeDatalight();
                            },
                            value: 2,
                            child: RowWidget(
                              text: 'light'.tr,
                              icon: Icons.light_mode,
                            )),
                      ],
                      color: AppColors.grey,
                      elevation: AppSizes.r2,
                    ),
                    AppSizes.r16.ph,
                    PopupMenuButton(
                      icon: Icon(
                        Icons.language,
                        color: AppColors.black,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {
                            controller.changelocale('en');
                          },
                          value: 1,
                          child: RowWidget(
                            text: 'english'.tr,
                            icon: Icons.translate,
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            controller.changelocale('ar');
                          },
                          value: 2,
                          child: RowWidget(
                            text: 'arabic'.tr,
                            icon: Icons.translate,
                          ),
                        ),
                      ],
                      color: AppColors.grey,
                      elevation: AppSizes.r2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: controller.res == false
              ? InternetWidget(
                  onPressed: () => controller.onInit(),
                )
              : controller.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.blue,
                      ),
                    )
                  : FutureBuilder(
                      future: controller.getData(),
                      builder: (context, AsyncSnapshot snapshot) {
                        DataWeather? dataWeather =
                            snapshot.data as DataWeather?;
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: 1,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: EdgeInsetsDirectional.only(
                                  start: AppSizes.r16,
                                  end: AppSizes.r16,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.black12,
                                          borderRadius: BorderRadius.circular(
                                              AppSizes.r10),
                                          border: Border.all(
                                            color: AppColors.grey700,
                                            width: AppSizes.r1,
                                          )),
                                      child: Padding(
                                        padding:
                                            EdgeInsetsDirectional.symmetric(
                                          horizontal: AppSizes.r16,
                                          vertical: AppSizes.r8,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.location_pin,
                                              color: AppColors.blue,
                                            ),
                                            AppSizes.r4.pw,
                                            TextWidget(
                                              text: (dataWeather != null)
                                                  ? dataWeather.name
                                                      .toString()
                                                      .toUpperCase()
                                                  : 'no city',
                                              fontSize: FontSizes.sp18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    AppSizes.r10.ph,
                                    TextWidget(
                                      text: controller.getDatTimeDate(),
                                      fontSize: FontSizes.sp14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    AppSizes.r16.ph,
                                    //----------------images weather-----------------------------------
                                    if (dataWeather?.weather![index].icon ==
                                        '01d')
                                      Image.asset(
                                        'assets/images/clear.png',
                                        width: 160,
                                      ),
                                    if (dataWeather?.weather![index].icon ==
                                        '01n')
                                      Image.asset(
                                        'assets/images/clear_night.png',
                                        width: 160,
                                      ),
                                    if (dataWeather
                                                ?.weather![index].icon ==
                                            '02d' ||
                                        dataWeather?.weather![index].icon ==
                                            '03d' ||
                                        dataWeather?.weather![index].icon ==
                                            '04d')
                                      Image.asset(
                                        'assets/images/sunny.png',
                                        width: 160,
                                      ),
                                    if (dataWeather
                                                ?.weather![index].icon ==
                                            '02n' ||
                                        dataWeather?.weather![index].icon ==
                                            '03n' ||
                                        dataWeather?.weather![index].icon ==
                                            '04n')
                                      Image.asset(
                                        'assets/images/night.png',
                                        width: 160,
                                      ),
                                    if (dataWeather
                                                ?.weather![index].icon ==
                                            '09d' ||
                                        dataWeather
                                                ?.weather![index].icon ==
                                            '10d' ||
                                        dataWeather?.weather![index].icon ==
                                            '09n' ||
                                        dataWeather?.weather![index].icon ==
                                            '10n')
                                      Image.asset(
                                        'assets/images/rain.png',
                                        width: 160,
                                      ),
                                    if (dataWeather?.weather![index].icon ==
                                            '11d' ||
                                        dataWeather?.weather![index].icon ==
                                            '11n')
                                      Image.asset(
                                        'assets/images/thunderstorm.png',
                                        width: 160,
                                      ),
                                    Row(
                                      textDirection: TextDirection.ltr,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: (dataWeather != null)
                                              ? '${dataWeather.main!.temp!.round()}'
                                              : '',
                                          fontSize: FontSizes.sp48,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        TextWidget(
                                          text: '\u2103',
                                          fontSize: FontSizes.sp24,
                                          fontWeight: FontWeight.w600,
                                        )
                                      ],
                                    ),
                                    AppSizes.r16.ph,
                                    TextWidget(
                                      text: (dataWeather != null)
                                          ? '${dataWeather.weather![index].description}'
                                              .capitalize!
                                          : '',
                                      fontSize: FontSizes.sp16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    AppSizes.r28.ph,
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            RowWidgetTwo(
                                              icon: Icons.cloud,
                                              text: 'clouds'.tr,
                                              textWeather: (dataWeather != null)
                                                  ? ' : ${dataWeather.clouds!.all} %'
                                                  : '',
                                            ),
                                            RowWidgetTwo(
                                              icon: Icons.air,
                                              text: 'wind'.tr,
                                              textWeather: (dataWeather != null)
                                                  ? ' : ${(dataWeather.wind!.speed! * 3.6).round()} km/h'
                                                      .tr
                                                  : '',
                                            ),
                                          ],
                                        ),
                                        AppSizes.r16.ph,
                                        Row(
                                          children: [
                                            RowWidgetTwo(
                                              icon: Icons.water_drop,
                                              text: 'humidity'.tr,
                                              textWeather: (dataWeather != null)
                                                  ? ' : ${dataWeather.main!.humidity} %'
                                                  : '',
                                            ),
                                            RowWidgetTwo(
                                              icon: Icons.check_circle_outline,
                                              text: 'pressure'.tr,
                                              textWeather: (dataWeather != null)
                                                  ? ' : ${dataWeather.main!.pressure} hPa'
                                                  : '',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    AppSizes.r28.ph,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                          text: 'forcast next 5 days'
                                              .tr
                                              .toUpperCase(),
                                          fontSize: FontSizes.sp14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: AppSizes.r16,
                                        ),
                                      ],
                                    ),
                                    AppSizes.r10.ph,
                                    Obx(
                                      () => FutureBuilder(
                                          future: controller.getDatatow(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            FiveDayData? fiveDayData =
                                                snapshot.data as FiveDayData?;

                                            return SizedBox(
                                              height: AppSizes.r170,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    fiveDayData?.list!.length,
                                                itemBuilder: ((context, index) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .all(
                                                      AppSizes.r2,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: AppColors
                                                                  .grey,
                                                              width:
                                                                  AppSizes.r5,
                                                            ),
                                                            color: AppColors
                                                                .black12,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              AppSizes.r28,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .all(
                                                              AppSizes.r12,
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                TextWidget(
                                                                  text: (fiveDayData !=
                                                                          null)
                                                                      ? '${controller.getCurrentDateFiveDay(fiveDayData.list![index].dtTxt!)}'
                                                                      : '',
                                                                  fontSize:
                                                                      FontSizes
                                                                          .sp12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                                TextWidget(
                                                                  text: (fiveDayData !=
                                                                          null)
                                                                      ? '${controller.getCurrentDateFiveDayjm(fiveDayData.list![index].dtTxt!)}'
                                                                      : '',
                                                                  fontSize:
                                                                      FontSizes
                                                                          .sp12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),

                                                                //----------------images weather-----------------------------------
                                                                if (fiveDayData
                                                                        ?.list![
                                                                            index]
                                                                        .weather![
                                                                            0]
                                                                        .icon ==
                                                                    '01d')
                                                                  Image.asset(
                                                                    'assets/images/clear.png',
                                                                    width: 50,
                                                                    height: 50,
                                                                  ),
                                                                if (fiveDayData
                                                                        ?.list![
                                                                            index]
                                                                        .weather![
                                                                            0]
                                                                        .icon ==
                                                                    '01n')
                                                                  Image.asset(
                                                                    'assets/images/clear_night.png',
                                                                    width: 50,
                                                                    height: 50,
                                                                  ),
                                                                if (fiveDayData?.list![index].weather![0].icon == '02d' ||
                                                                    fiveDayData
                                                                            ?.list![
                                                                                index]
                                                                            .weather![
                                                                                0]
                                                                            .icon ==
                                                                        '03d' ||
                                                                    fiveDayData
                                                                            ?.list![index]
                                                                            .weather![0]
                                                                            .icon ==
                                                                        '04d')
                                                                  Image.asset(
                                                                    'assets/images/sunny.png',
                                                                    width: 50,
                                                                    height: 50,
                                                                  ),
                                                                if (fiveDayData?.list![index].weather![0].icon == '02n' ||
                                                                    fiveDayData
                                                                            ?.list![
                                                                                index]
                                                                            .weather![
                                                                                0]
                                                                            .icon ==
                                                                        '03n' ||
                                                                    fiveDayData
                                                                            ?.list![index]
                                                                            .weather![0]
                                                                            .icon ==
                                                                        '04n')
                                                                  Image.asset(
                                                                    'assets/images/night.png',
                                                                    width: 50,
                                                                    height: 50,
                                                                  ),
                                                                if (fiveDayData?.list![index].weather![0].icon == '09d' ||
                                                                    fiveDayData
                                                                            ?.list![
                                                                                index]
                                                                            .weather![
                                                                                0]
                                                                            .icon ==
                                                                        '10d' ||
                                                                    fiveDayData
                                                                            ?.list![
                                                                                index]
                                                                            .weather![
                                                                                0]
                                                                            .icon ==
                                                                        '09n' ||
                                                                    fiveDayData
                                                                            ?.list![index]
                                                                            .weather![0]
                                                                            .icon ==
                                                                        '10n')
                                                                  Image.asset(
                                                                    'assets/images/rain.png',
                                                                    width: 50,
                                                                    height: 50,
                                                                  ),
                                                                if (fiveDayData
                                                                            ?.list![
                                                                                index]
                                                                            .weather![
                                                                                0]
                                                                            .icon ==
                                                                        '11d' ||
                                                                    fiveDayData
                                                                            ?.list![index]
                                                                            .weather![0]
                                                                            .icon ==
                                                                        '11n')
                                                                  Image.asset(
                                                                    'assets/images/thunderstorm.png',
                                                                    width: 50,
                                                                    height: 50,
                                                                  ),

                                                                //----------------images weather-----------------------------------

                                                                TextWidget(
                                                                  text: (fiveDayData !=
                                                                          null)
                                                                      ? '${fiveDayData.list![index].main!.tempMin!.round()}\u2103 / ${fiveDayData.list![index].main!.tempMax!.round()}\u2103'
                                                                      : '',
                                                                  fontSize:
                                                                      FontSizes
                                                                          .sp12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                                AppSizes.r8.ph,
                                                                TextWidget(
                                                                  text: (fiveDayData !=
                                                                          null)
                                                                      ? '${fiveDayData.list![index].weather![0].description}'
                                                                          .capitalize!
                                                                      : '',
                                                                  fontSize:
                                                                      FontSizes
                                                                          .sp12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              );
                            }),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.blue,
                            ),
                          );
                        }
                      }),
        ),
      ),
    );
  }
}
