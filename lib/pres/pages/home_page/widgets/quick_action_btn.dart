import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app_color/app_colors.dart';

class QuickActionBtn extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool isColor;
  final VoidCallback? onTap;
  const QuickActionBtn({
    super.key,
    required this.text,
    required this.icon,
    this.isColor = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        height: 38.06.h,
        width: 110.36.w,
        decoration: BoxDecoration(
          color: isColor == true ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,

              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          spacing: 4.w,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isColor == true ? AppColors.white : AppColors.text,
              size: 18.r,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: isColor == true ? AppColors.white : AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
