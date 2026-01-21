import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_color/app_colors.dart';

class CustomCardWidget extends StatelessWidget {
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String title;
  final String subTitle;
  final String? trailingTitle;
  final String? trailingSubTitle;
  final VoidCallback? onTap;
  bool isSaved;
  CustomCardWidget({
    super.key,
    this.leadingIcon,
    this.trailingIcon,
    required this.title,
    required this.subTitle,
    this.trailingTitle,
    this.trailingSubTitle,
    this.onTap,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 6.81.w,
              children: [
                Container(
                  height: 34.35.h,
                  width: 34.35.w,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    leadingIcon ?? Icons.qr_code,
                    color: AppColors.white,
                    size: 15.r,
                  ),
                ),
                Column(
                  spacing: 4.5.h,

                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 122.w,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        title,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      width: 122.w,
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        subTitle,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.secondText,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  trailingIcon == null
                      ? Column(
                          spacing: 4.5.h,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            trailingTitle != null
                                ? SizedBox(
                                    width: 122.w,
                                    child: Text(
                                      textAlign: TextAlign.end,

                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      isSaved == true ? 'Saved' : 'Unsaved',
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: isSaved == true
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : Container(),
                            trailingTitle != null
                                ? SizedBox(
                                    width: 122.w,
                                    child: Text(
                                      textAlign: TextAlign.end,

                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      trailingTitle!,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: AppColors.secondText,
                                      ),
                                    ),
                                  )
                                : Container(),
                            // trailingSubTitle != null
                            //     ? SizedBox(
                            //         width: 122.w,
                            //         child: Text(
                            //           textAlign: TextAlign.end,
                            //           maxLines: 1,
                            //           overflow: TextOverflow.ellipsis,
                            //           trailingTitle!,
                            //           style: TextStyle(
                            //             fontSize: 10.sp,
                            //             color: AppColors.secondText,
                            //           ),
                            //         ),
                            //       )
                            //     : Container(),
                          ],
                        )
                      : Icon(trailingIcon, color: AppColors.secondText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
