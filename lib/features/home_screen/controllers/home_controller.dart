// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/style/app_sizes.dart';
import 'package:flutter_application_1/core/widgets/sized_box.dart';
import 'package:flutter_application_1/model/class_five_day_data.dart';
import 'package:flutter_application_1/model/class_data_weather.dart';
import 'package:flutter_application_1/core/service/weather_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  final isLoading = false.obs;

  @override
  void onInit() async {
    isLoading(true);
    position = await determinePosition();
    res = await checkInternet();

    isLoading(false);
    super.onInit();
  }

  Position? position;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  var res;

  checkInternet() async {
    try {
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  changelocale(String codelang) async {
    Locale locale = Locale(codelang);
    GetStorage().write('lang', codelang);
    Get.updateLocale(locale);
  }

  Locale getlocale() {
    Locale locale = GetStorage().read('lang') == null
        ? Get.deviceLocale!
        : Locale(GetStorage().read('lang'));
    return locale;
  }

  getThemeDatalight() {
    Get.changeTheme(ThemeData.light(useMaterial3: true));
    GetStorage().write('themeData', 'light');
  }

  getThemeDatadark() {
    Get.changeTheme(ThemeData.dark(useMaterial3: true));
    GetStorage().write('themeData', 'dark');
  }

  updateLat(double lat) {
    latitude(lat);
  }

  updateLon(double lon) {
    longitude(lon);
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

  Future<DataWeather?> getData() async {
    String url = '';
    if (latitude == 0.0.obs && longitude == 0.0.obs) {
      url =
          '${Service.baseUrl}/weather?lat=${position!.latitude}&lon=${position!.longitude}&${Service.units}&lang=${getlocale().languageCode}&${Service.apiKey}';
    } else {
      url =
          '${Service.baseUrl}/weather?lat=$latitude&lon=$longitude&${Service.units}&lang=${getlocale().languageCode}&${Service.apiKey}';
    }

    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      try {
        return DataWeather.fromJson(json);
      } catch (e) {
        print('error; ${e.toString()}');
      }
    }

    return null;
  }

  Future<FiveDayData?> getDatatow() async {
    String url = '';
    if (latitude == 0.0.obs && longitude == 0.0.obs) {
      url =
          '${Service.baseUrl}/forecast?lat=${position!.latitude}&lon=${position!.longitude}&${Service.units}&lang=${getlocale().languageCode}&${Service.apiKey}';
    } else {
      url =
          '${Service.baseUrl}/forecast?lat=$latitude&lon=$longitude&${Service.units}&lang=${getlocale().languageCode}&${Service.apiKey}';
    }

    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      try {
        return FiveDayData.fromJson(json);
      } catch (e) {
        print('error; ${e.toString()}');
      }
    }
    return null;
  }

  var presscount = 0;
  willPopScope(context) {
    presscount++;

    if (presscount == 2) {
      exit(0);
    } else {
      var snackBar = SnackBar(
        content: Text('willPopScope'.tr),
        duration: const Duration(
          seconds: 5,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  List<String> monthsEN = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  List<String> monthsAR = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];
  List<String> weeksEN = [
    '',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  List<String> weeksAR = [
    '',
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];
  String getDatTimeDate() {
    DateTime now = DateTime.now();
    if (getlocale().languageCode == 'en') {
      return "${weeksEN[now.weekday]}, ${monthsEN[now.month - 1]} ${now.day}";
    }
    return "${weeksAR[now.weekday]}, ${monthsAR[now.month - 1]} ${now.day}";
  }

  getCurrentDateFiveDay(DateTime fiveDay) {
    return DateFormat().add_Md().format(fiveDay);
  }

  getCurrentDateFiveDayjm(DateTime fiveDay) {
    return DateFormat().add_jm().format(fiveDay);
  }

  showMyDialog() async {
    return Get.defaultDialog(
      title: 'refresh_location'.tr,
      content: Column(
        children: [
          Text('refresh_location_2'.tr),
          AppSizes.r16.ph,
          const Divider(
            height: 0,
            color: Colors.black38,
            thickness: 1,
          ),
        ],
      ),
      textCancel: 'cancel'.tr,
      textConfirm: 'ok'.tr,
      radius: 10,
      confirmTextColor: Colors.white,
      barrierDismissible: false,
      titlePadding: const EdgeInsets.only(top: 16, bottom: 8),
      onCancel: () {
        Get.close(0);
      },
      onConfirm: () {
        Get.isLogEnable;
        latitude.value = 0.0;
        longitude.value = 0.0;
        Get.close(0);
      },
    );
  }
}
/*  Future<DataWeather?> getData() async {
    var response = await Dio().get(
        '${Service.baseUrl}/weather?q=$storeName&${Service.units}&${Service.lang}&${Service.apiKey}');
    if (response.statusCode == 200) {
      try {
        return DataWeather.fromJson(response.data);
      } catch (e) {
        Get.snackbar('error', e.toString());
      }
    }
    return null;
  }
*/

  /* Future<FiveDayData?> getDatatow() async {
    var response = await Dio().get(
        '${Service.baseUrl}/forecast?q=$storeName&${Service.units}&${Service.lang}&${Service.apiKey}');
    if (response.statusCode == 200) {
      try {
        return FiveDayData.fromJson(response.data);
      } catch (e) {
        Get.snackbar('error', e.toString());
        print(e.toString());
      }
    }

    return null;
  }*/