import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
                // rgba(25, 23, 43, 1)
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
