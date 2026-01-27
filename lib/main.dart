import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:scan_app/data/handlers/ads_handler.dart';
import 'package:scan_app/data/storage/settings_storage.dart';

import 'package:scan_app/pres/bloc/export_excel_bloc/excel_bloc.dart';
import 'package:scan_app/pres/bloc/history_bloc/history_bloc.dart';
import 'package:scan_app/pres/bloc/home_page_bloc/home_page_bloc.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nave_bar_bloc.dart';
import 'package:scan_app/pres/bloc/scan_save_bloc/category_bloc.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_bloc.dart';
import 'package:scan_app/pres/bloc/setting_bloc/settings_bloc.dart';
import 'package:scan_app/pres/bloc/setting_bloc/settings_event.dart';
import 'package:scan_app/pres/pages/splash_page.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await SettingsStorage.getSound();
  await SettingsStorage.getVibration();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: Size(390, 844),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NaveBarBloc()),
          BlocProvider(create: (context) => ScannerBloc()),
          BlocProvider(create: (context) => HistoryBloc()),
          BlocProvider(create: (context) => CategoryBloc()),
          BlocProvider(create: (context) => ExportExcelBloc()),
          BlocProvider(create: (context) => HomePageBloc()),
          BlocProvider(create: (context) => SettingsBloc()..add(OnLoadEvent())),

          // BlocProvider(create: (context) => AdsBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await MobileAds.instance.initialize();
//
//   // Test device IDs (replace with your device ID)
//   await MobileAds.instance.updateRequestConfiguration(
//     RequestConfiguration(testDeviceIds: ["B73D3B4C1A77B66A6FFED0436F651947"]),
//   );
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   AppOpenAd? _appOpenAd;
//   bool _isAdLoaded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _loadAppOpenAd();
//   }
//
//   // App Open Ad Unit ID
//   String get appOpenAdUnitId {
//     if (Theme.of(context).platform == TargetPlatform.android) {
//       return 'ca-app-pub-3940256099942544/3419835294'; // Android test ID
//     } else if (Theme.of(context).platform == TargetPlatform.iOS) {
//       return 'ca-app-pub-3940256099942544/5662855259'; // iOS test ID
//     } else {
//       throw UnsupportedError('Unsupported platform');
//     }
//   }
//
//   void _loadAppOpenAd() {
//     AppOpenAd.load(
//       adUnitId: appOpenAdUnitId,
//       request: const AdRequest(),
//       adLoadCallback: AppOpenAdLoadCallback(
//         onAdLoaded: (ad) {
//           _appOpenAd = ad;
//           _isAdLoaded = true;
//           _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
//             onAdDismissedFullScreenContent: (ad) {
//               _appOpenAd = null;
//               _isAdLoaded = false;
//               _loadAppOpenAd(); // Reload next ad
//             },
//             onAdFailedToShowFullScreenContent: (ad, error) {
//               _appOpenAd = null;
//               _isAdLoaded = false;
//               print('Failed to show ad: $error');
//             },
//           );
//         },
//         onAdFailedToLoad: (error) {
//           _isAdLoaded = false;
//           print('App Open Ad failed to load: $error');
//         },
//       ),
//     );
//   }
//
//   void _showAppOpenAd() {
//     if (_isAdLoaded && _appOpenAd != null) {
//       _appOpenAd!.show();
//     } else {
//       print('App Open Ad not ready yet');
//     }
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _showAppOpenAd(); // Show ad when app comes to foreground
//     }
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'App Open Ad Demo',
//       home: const SplashScreen(),
//     );
//   }
// }
//
// // Simple Splash Screen
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Navigate to Home after 2 seconds
//     Future.delayed(const Duration(seconds: 2), () {
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const HomePage()));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           'Splash Screen',
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }
//
// // Simple Home Page
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           'Welcome to the app!',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
