import 'dart:ui';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:scan_app/constant/mobile_ads_key.dart';
import 'package:scan_app/data/storage/ads_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InterstitialAdManager {
  static InterstitialAd? _ad;

  static bool isReady = false;

  static Future<bool> load() async {
    await InterstitialAd.load(
      adUnitId: AdsKey.openAdsKey(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          isReady = true;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) async {
              ad.dispose();
              isReady = false;
              await AdsStorage.firstTimeAppOpenAd(isFirstTimeAdsShow: false);
              print('load 1${await AdsStorage.getFirstTimeAppOpenAdsValue()}');
            },
          );
        },
        onAdFailedToLoad: (error) {
          isReady = false;
        },
      ),
    );
    return isReady;
  }

  static Future<void> show(VoidCallback onAdClosed) async {
    if (isReady && _ad != null) {
      _ad!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) async {
          ad.dispose();
          isReady = false;
          onAdClosed();
          await AdsStorage.firstTimeAppOpenAd(isFirstTimeAdsShow: false);
          print('show 1${await AdsStorage.getFirstTimeAppOpenAdsValue()}');
        },
      );
      _ad!.show();
    } else {
      onAdClosed();
    }
  }
}
