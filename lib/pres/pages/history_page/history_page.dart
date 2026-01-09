import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_app/pres/app_color/app_colors.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nav_bar_event.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nave_bar_bloc.dart';
import 'package:scan_app/pres/widgets/app_btn.dart';
import 'package:scan_app/pres/widgets/custom_cord_widget.dart';

import '../../widgets/app_t_field.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        children: [
          /// Header
          SizedBox(height: 54.26.h),
          Row(
            spacing: 10.w,
            children: [
              InkWell(
                onTap: () {
                  context.read<NaveBarBloc>().add(NaveBarIndexEvent(value: 1));
                },
                child: Icon(Icons.arrow_back_ios_new),
              ),
              Text('History', style: TextStyle(fontSize: 20.sp)),
            ],
          ),
          SizedBox(height: 22.81.h),

          /// Search Bar
          AppTField(hintText: 'Search here'),
          SizedBox(height: 13.33.h),
          Row(
            spacing: 5.w,
            children: [
              Expanded(child: Divider(color: AppColors.text)),
              Text(
                'Scan History',
                style: TextStyle(fontSize: 20.sp, color: AppColors.text),
              ),
              Expanded(child: Divider(color: AppColors.text)),
            ],
          ),
          SizedBox(height: 13.33.h),
          AppBtn(
            title: 'Export to Excel',
            icon: CupertinoIcons.doc,
            onTap: () {},
          ),
          SizedBox(height: 13.96.h),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.60,
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  (19),
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      bottom: index == 18 ? 100.3.h : 16.4.h,
                    ),
                    child: CustomCardWidget(
                      title: 'Website #$index',
                      subTitle: 'Dec 15, 2025 at 10:30 AM',
                      trailingIcon: Icons.arrow_forward_ios_outlined,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
