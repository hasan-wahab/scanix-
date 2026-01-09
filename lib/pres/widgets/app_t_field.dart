import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color/app_colors.dart';

class AppTField extends StatelessWidget {
  final String hintText;
  final Function(String? value)? onChanged;
  final IconData? startIcon;
  final IconData? endIcon;
  final TextEditingController? controller;
  final int? maxLines;
  final bool obscureText = false;
  const AppTField({
    super.key,
    required this.hintText,
    this.onChanged,
    this.startIcon,
    this.endIcon,
    this.controller,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.06.h,
      child: CupertinoTextField(
        onChanged: onChanged,
        controller: controller,
        maxLines: maxLines,
        obscureText: obscureText,

        placeholder: hintText,
        placeholderStyle: TextStyle(
          color: AppColors.secondText,
          fontSize: 16.sp,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38 / 2.r),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(offset: Offset(0, 4), color: Colors.grey, blurRadius: 8),
          ],
        ),
        prefix:startIcon==null? Padding(
          padding: EdgeInsets.only(left: 17.3.w, right: 5.w),
          child: Icon(
            CupertinoIcons.search,
            size: 19.r,
            color: AppColors.secondText,
          ),
        ):null,
        suffix:endIcon==null? Padding(
          padding: EdgeInsets.only(right: 16.3.w),
          child: Icon(
            CupertinoIcons.color_filter,
            size: 17.r,
            color: AppColors.secondText,
          ),
        ):null,
      ),
    );
  }
}
