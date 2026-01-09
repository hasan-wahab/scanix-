import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app_color/app_colors.dart';

class SecondContainerWidget extends StatelessWidget {
  const SecondContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      height: 93.32.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 5.w,
                children: [
                  Icon(Icons.info, color: AppColors.text, size: 20.r),
                  Text('About App'),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColors.secondText,
                size: 20.r,
              ),
            ],
          ),
          Divider(color: AppColors.secondText),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 5.w,
                children: [
                  Icon(
                    Icons.access_alarm_sharp,
                    color: AppColors.text,
                    size: 20.r,
                  ),
                  Text('Privacy Policy'),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColors.secondText,
                size: 20.r,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
