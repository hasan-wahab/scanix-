import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_app/pres/pages/live_scanner/live_scanner.dart';

import '../../../app_color/app_colors.dart';
import '../../../bloc/nave_bar_bloc/nav_bar_event.dart';
import '../../../bloc/nave_bar_bloc/nave_bar_bloc.dart';

class BottomNaveBar extends StatelessWidget {
  const BottomNaveBar({super.key});

  @override
  Widget build(BuildContext context) {
    final safeArea = MediaQuery.of(context).padding;
    const List<IconData> iconList = [
      Icons.history,
      Icons.history,
      Icons.settings,
    ];
    const List<String> textList = ['History', '', 'Settings'];
    return SizedBox(
      height: 76.h + safeArea.bottom,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              offset: Offset(0, -5),
              blurRadius: 2,
              spreadRadius: 0.01,
            ),
          ],
        ),
        padding: EdgeInsets.only(right: 22.w, left: 22.w, top: 22.h),
        alignment: Alignment.topCenter,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(textList.length, (index) {
              return InkWell(
                onTap: () {
                  context.read<NaveBarBloc>().add(NaveBarIndexEvent(value: index));
                },
                child: Column(
                  spacing: 5.h,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      iconList[index],
                      size: 30.r,
                      color: index == 1 ? Colors.white : AppColors.primary,
                    ),
                    Text(
                      textList[index],
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
