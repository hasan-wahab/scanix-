import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_app/pres/app_color/app_colors.dart';

class AppBtn extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final double? height;
  final double? width;
  const AppBtn({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: width ?? 197.54.h,
            height: height ?? 38.06.w,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              spacing: 5.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16.r, color: AppColors.white),
                Text(
                  title,
                  style: TextStyle(fontSize: 13.sp, color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
