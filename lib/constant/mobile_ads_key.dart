import 'dart:io';

class AdsKey {
  AdsKey._();

  static String openAdsKey() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/1033173712';
    } else {
      return '';
    }
  }
  static String bannerKey() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else {
      return '';
    }
  }
}
