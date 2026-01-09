import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color/app_colors.dart';

class SwitchButton extends StatelessWidget {
  final bool switchValue;
  final VoidCallback onTap;
  const SwitchButton({
    super.key,
    required this.switchValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.37.w),
        width: 48.w,
        height: 22.57.h,
        decoration: BoxDecoration(
          color: switchValue ? AppColors.primary : AppColors.secondText,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisAlignment: switchValue
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              width: 16.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
