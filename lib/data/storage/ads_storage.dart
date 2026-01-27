import 'package:shared_preferences/shared_preferences.dart';

class AdsStorage {
  AdsStorage._();

  static Future<void> firstTimeAppOpenAd({
    required bool isFirstTimeAdsShow,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('IsFirstTimeShowAd', isFirstTimeAdsShow);
  }

  static Future<bool> getFirstTimeAppOpenAdsValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool result =  prefs.getBool('IsFirstTimeShowAd')!;
    return result;
  }
}
