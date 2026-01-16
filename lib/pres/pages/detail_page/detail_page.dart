import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/history_model.dart';

class DetailPage extends StatelessWidget {
  HistoryModel data;

  DetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          SizedBox(height: 54.26.h),
          Row(
            spacing: 10.w,
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new),
              ),
              Text('History', style: TextStyle(fontSize: 20.sp)),
            ],
          ),
          SizedBox(height: 22.81.h),
          Text(data.data.toString()),
        ],
      ),
    );
  }
}
