import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_app/data/models/history_model.dart';
import 'package:scan_app/data/storage/histrory.dart';
import 'package:scan_app/pres/app_color/app_colors.dart';
import 'package:scan_app/pres/pages/home_page/widgets/quick_action_btn.dart';

import '../../widgets/custom_cord_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<HistoryModel?> history = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgColor,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 22.w),

        children: [
          SizedBox(height: 81.4.h),

          /// Heading
          Text(
            'Hello, Ahmad!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp),
          ),
          SizedBox(height: 48.26.h),
          Text('Quick Actions', style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 10.42.h),

          /// Action Button Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuickActionBtn(
                onTap: () {},
                icon: Icons.qr_code,
                text: 'Scan Now',
                isColor: true,
              ),
              QuickActionBtn(onTap: () {}, icon: Icons.qr_code, text: 'Export'),
              QuickActionBtn(
                onTap: () {},
                icon: Icons.qr_code,
                text: 'View History',
              ),
            ],
          ),
          SizedBox(height: 95.4.h),
          Text('Recent Scans Preview', style: TextStyle(fontSize: 16.sp)),
          SizedBox(height: 19.4.h),

          /// Card List
          /// Recent Scans Preview
          ...List.generate((history.length), (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 15.12.h),
              child: CustomCardWidget(
                title: history[index]!.scanType ?? '',
                subTitle: history[index]!.scanType ?? "",
                trailingTitle: history[index]!.data ?? '',
                trailingSubTitle: history[index]!.date ?? '',
              ),
            );
          }),
        ],
      ),
    );
  }

  void getData() async {
    final data = await History.getData(key: 'data');
    if (data.isNotEmpty) {
      history = data;
    }
  }
}
