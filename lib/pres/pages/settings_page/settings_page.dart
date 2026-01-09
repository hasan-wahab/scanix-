import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_app/pres/app_color/app_colors.dart';
import 'package:scan_app/pres/pages/settings_page/widgets/second_container_widget.dart';
import 'package:scan_app/pres/widgets/switch_button.dart';

import '../../bloc/nave_bar_bloc/nav_bar_event.dart';
import '../../bloc/nave_bar_bloc/nave_bar_bloc.dart';
import 'widgets/container_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w),

      color: AppColors.bgColor,
      child: Column(
        children: [
          SizedBox(height: 54.26.h),

          /// Header
          Row(
            spacing: 10.w,
            children: [
              InkWell(
                onTap: () {
                  context.read<NaveBarBloc>().add(NaveBarIndexEvent(value: 1));
                },
                child: Icon(Icons.arrow_back_ios_new),
              ),
              Text('Settings', style: TextStyle(fontSize: 20.sp)),
            ],
          ),
          SizedBox(height: 14.49.h),
          Divider(color: AppColors.secondText),
          SizedBox(height: 61.02.h),

          /// Scan Sound | Vibration | Language
          ContainerWidget(
            onTap: () {
              setState(() {
                switchValue = !switchValue;
              });
            },
            switchValue: switchValue,
          ),
          SizedBox(height: 12.06.h),

          /// About App | Privacy Policy
          SecondContainerWidget(),
        ],
      ),
    );
  }
}
