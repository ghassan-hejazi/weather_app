import 'package:get/get.dart';

class MyLocale extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'clouds': 'Clouds',
          'wind': 'Wind',
          'humidity': 'Humidity',
          'pressure': 'Pressure',
          'forcast next 5 days': 'forcast next 5 days',
          'citys': 'Select City',
          'refresh_location': 'Refresh location',
          'refresh_location_2': 'Do you want to refresh your location?',
          'ok': 'OK',
          'cancel': 'Cancel',
          'dark': 'dark mode',
          'light': 'light mode',
          'english': 'english',
          'arabic': 'arabic',
          'willPopScope': 'press another time to exit from app',
        },
        'ar_SA': {
          'clouds': 'سحاب',
          'wind': 'رياح',
          'humidity': 'رطوبة',
          'pressure': 'ضغط',
          'forcast next 5 days': 'توقع 5 أيام القادمة',
          'citys': 'اختر مدينة',
          'refresh_location': 'تحديث الموقع',
          'refresh_location_2': 'هل تريد تحديث موقعك؟',
          'ok': 'نعم',
          'cancel': 'إلغاء',
          'dark': 'الوضع المظلم',
          'light': 'وضع الضوء',
          'english': 'english',
          'arabic': 'العربية',
          'willPopScope': 'اضغط مرة أخرى للخروج من التطبيق',
        }
      };
}
