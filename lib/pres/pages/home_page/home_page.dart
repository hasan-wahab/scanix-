import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:open_file/open_file.dart';
import 'package:scan_app/constant/mobile_ads_key.dart';
import 'package:scan_app/data/handlers/ads_handler.dart';

import 'package:scan_app/data/models/history_model.dart';
import 'package:scan_app/data/storage/ads_storage.dart';
import 'package:scan_app/pres/app_color/app_colors.dart';
import 'package:scan_app/pres/bloc/export_excel_bloc/excel_bloc.dart';
import 'package:scan_app/pres/bloc/export_excel_bloc/excel_event.dart';
import 'package:scan_app/pres/bloc/export_excel_bloc/excel_state.dart';
import 'package:scan_app/pres/bloc/history_bloc/history_bloc.dart';
import 'package:scan_app/pres/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:scan_app/pres/bloc/home_page_bloc/home_page_event.dart';
import 'package:scan_app/pres/bloc/home_page_bloc/home_page_state.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nav_bar_event.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nave_bar_bloc.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_bloc.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_events.dart';
import 'package:scan_app/pres/pages/detail_page/detail_page.dart';
import 'package:scan_app/pres/pages/home_page/widgets/quick_action_btn.dart';
import 'package:scan_app/pres/widgets/custom_cord_widget.dart';
import 'package:scan_app/pres/widgets/save_dilog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HistoryModel?> history = [];

  // BannerAd? _bannerAd;
  // bool _isBannerLoaded = false;
  // late Timer _timer;

  @override
  void initState() {
    super.initState();
    context.read<HomePageBloc>().add(HomeGetHistoryEvent());
    // addLoad();
  }

  // Widget bannerWithClose() {
  //   if (!_isBannerLoaded) return const SizedBox();
  //
  //   return Stack(
  //     children: [
  //       SizedBox(
  //         width: _bannerAd!.size.width.toDouble(),
  //         height: _bannerAd!.size.height.toDouble(),
  //         child: AdWidget(ad: _bannerAd!),
  //       ),
  //
  //       // ❌ Close Button
  //       Positioned(
  //         right: 4,
  //         top: 4,
  //         child: GestureDetector(
  //           onTap: () {
  //             setState(() {
  //               _bannerAd?.dispose();
  //               _bannerAd = null;
  //               _isBannerLoaded = false;
  //             });
  //           },
  //           child: Container(
  //             padding: const EdgeInsets.all(4),
  //             decoration: BoxDecoration(
  //               color: Colors.black54,
  //               shape: BoxShape.circle,
  //             ),
  //             child: const Icon(Icons.close, size: 16, color: Colors.white),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // void _loadBannerAd() {
  //   _bannerAd = BannerAd(
  //     adUnitId: AdsKey.bannerKey(),
  //     size: AdSize.banner,
  //     request: const AdRequest(),
  //     listener: BannerAdListener(
  //       onAdLoaded: (_) {
  //         setState(() {
  //           _isBannerLoaded = true;
  //         });
  //       },
  //       onAdClosed: (ad) {
  //         ad.dispose();
  //       },
  //       onAdFailedToLoad: (ad, error) {
  //         ad.dispose();
  //       },
  //     ),
  //   );
  //
  //   _bannerAd!.load();
  // }
  //
  // @override
  // void dispose() {
  //   _bannerAd?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        children: [
          SizedBox(height: 80.h),
          Text(
            'Quick Actions',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),

          ///  Quick Buttons
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              spacing: 20.w,
              children: [
                Expanded(
                  child: QuickActionBtn(
                    onTap: () {
                      context.read<NaveBarBloc>().add(OpenScannerEvent());
                    },
                    icon: Icons.qr_code,
                    text: 'Scan Now',
                    isColor: true,
                  ),
                ),

                Expanded(
                  child: QuickActionBtn(
                    onTap: () {
                      context.read<NaveBarBloc>().add(
                        NaveBarIndexEvent(value: 0),
                      );
                    },
                    icon: Icons.history,
                    text: 'History',
                    isColor: true,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 22.h),

          /// 🔹 Recent Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Scans Preview', style: TextStyle(fontSize: 16.sp)),
              InkWell(
                onTap: () {
                  context.read<HomePageBloc>().add(HomeDeleteAllHistoryEvent());
                },
                child: Text(
                  'Clear all',
                  style: TextStyle(fontSize: 12.sp, color: Colors.blue),
                ),
              ),
            ],
          ),

          SizedBox(height: 18.h),

          /// 🔹 HISTORY LIST + AD
          BlocConsumer<HomePageBloc, HomePageState>(
            listener: (context, state) async {
              if (state is HomePageHistoryState) {
                history = state.historyList ?? [];
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  // /// 🔹 ALWAYS SHOW AD
                  // if (_isBannerLoaded) bannerWithClose(),

                  /// 🔹 IF HISTORY EMPTY
                  if (history.isEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Text(
                        'No history found',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      ),
                    ),

                  /// 🔹 IF HISTORY NOT EMPTY
                  if (history.isNotEmpty)
                    Column(
                      children: List.generate(
                        history.length,
                        (index) => _buildHistoryCard(index),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  /// 🔹 CARD BUILDER
  Widget _buildHistoryCard(int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: InkWell(
        onTap: () async {
          if (history[index]!.isSaved == true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(data: history[index]!),
              ),
            );
          } else {
            await showDialog(
              context: context,
              builder: (context) => ScanSaveDialog(
                scanedData: history[index]!.data.toString(),
                scanName: history[index]!.scanType.toString(),
                index: index,
              ),
            );
          }
        },
        child: CustomCardWidget(
          title: history[index]!.scanType.toString(),
          subTitle: history[index]!.dateTime.toString(),
          trailingTitle: history[index]!.data.toString(),
          trailingSubTitle: history[index]!.category.toString(),
          isSaved: history[index]!.isSaved,
        ),
      ),
    );
  }

  // void addLoad() async {
  //   bool firstTimeAppOpen = await AdsStorage.getFirstTimeAppOpenAdsValue();
  //
  //   if (firstTimeAppOpen == true) {
  //    // _loadBannerAd();
  //     InterstitialAdManager.load();
  //     await Future.delayed(Duration(seconds: 3)).then((_) {
  //       if (InterstitialAdManager.isReady == true) {
  //         InterstitialAdManager.show(() async {
  //           await AdsStorage.firstTimeAppOpenAd(isFirstTimeAdsShow: false);
  //           print('ad Load${await AdsStorage.getFirstTimeAppOpenAdsValue()}');
  //         });
  //       }
  //     });
  //   }
  //   _timer = Timer.periodic(Duration(seconds: 15), (Timer timer) {
  //     _loadBannerAd();
  //   });
  // }
}
