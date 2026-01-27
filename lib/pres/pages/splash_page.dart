import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_app/data/storage/ads_storage.dart';
import 'package:scan_app/pres/pages/nave_bar_page/nave_bar.dart';

import '../../data/handlers/ads_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    delayOnSplashScreen();
    super.initState();
  }

  void delayOnSplashScreen() async {
    //  await AdsStorage.firstTimeAppOpenAd(isFirstTimeAdsShow: true);
    await Future.delayed(Duration(seconds: 3));
    if (!mounted) return;
    Navigator.of(
      context,
    ).pushReplacement(CupertinoPageRoute(builder: (context) => NaveBar()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(25, 23, 43, 1),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          spacing: 20.h,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 70,
                    spreadRadius: 1,
                    color: Colors.blue.shade600,
                  ),
                ],
              ),

              child: Image.asset('assets/images/splash_image.png'),
            ),
            Text(
              'Scanix',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: 40.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
