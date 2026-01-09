import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app_color/app_colors.dart';
import '../../../widgets/switch_button.dart';

class ContainerWidget extends StatelessWidget {
  final VoidCallback onTap;
  bool switchValue;

  ContainerWidget({super.key, required this.onTap, required this.switchValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      height: 136.24.h,
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
                children: [Icon(CupertinoIcons.speaker_2), Text('Scan Sound')],
              ),
              SwitchButton(switchValue: switchValue, onTap: onTap),
            ],
          ),
          Divider(color: AppColors.secondText),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 5.w,
                children: [
                  Icon(Icons.vibration_outlined, color: AppColors.text),
                  Text('Vibration'),
                ],
              ),
              SwitchButton(switchValue: switchValue, onTap: onTap),
            ],
          ),
          Divider(color: AppColors.secondText),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 5.w,
                children: [
                  Icon(CupertinoIcons.speaker_2, color: AppColors.text),
                  Text('Language'),
                ],
              ),
              Row(
                spacing: 5.w,
                children: [
                  Text('English'),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.secondText,
                    size: 20.r,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
