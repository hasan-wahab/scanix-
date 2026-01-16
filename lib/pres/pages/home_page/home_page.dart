import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:scan_app/data/models/history_model.dart';
import 'package:scan_app/data/storage/histrory.dart';
import 'package:scan_app/data/storage/recent_history.dart';
import 'package:scan_app/pres/app_color/app_colors.dart';
import 'package:scan_app/pres/bloc/export_excel_bloc/excel_bloc.dart';
import 'package:scan_app/pres/bloc/export_excel_bloc/excel_bloc.dart';
import 'package:scan_app/pres/bloc/history_bloc/history_bloc.dart';
import 'package:scan_app/pres/bloc/history_bloc/history_state.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nav_bar_event.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nave_bar_bloc.dart';
import 'package:scan_app/pres/pages/home_page/widgets/quick_action_btn.dart';

import '../../bloc/export_excel_bloc/excel_event.dart';
import '../../bloc/export_excel_bloc/excel_state.dart';
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
                onTap: () {
                  context.read<NaveBarBloc>().add(OpenScannerEvent());
                },
                icon: Icons.qr_code,
                text: 'Scan Now',
                isColor: true,
              ),
              BlocConsumer<ExportExcelBloc, ExportExcelState>(
                listener: (context, state) {
                  if (state is ExportExcelSuccess) {
                    OpenFile.open(state.filePath);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Excel saved successfully')),
                    );
                  }

                  if (state is ExportExcelError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                    print(state.message);
                  }
                },
                builder: (context, state) {
                  if (state is ExportExcelLoading) {
                    return CircularProgressIndicator();
                  }

                  return QuickActionBtn(
                    onTap: () {
                      context.read<ExportExcelBloc>().add(ExportUsersToExcel());
                      print('Export to excel');
                    },
                    icon: Icons.file_download,
                    text: 'Export',
                  );
                },
              ),

              QuickActionBtn(
                onTap: () {
                  context.read<NaveBarBloc>().add(NaveBarIndexEvent(value: 0));
                },
                icon: Icons.qr_code,
                text: 'View History',
              ),
            ],
          ),
          SizedBox(height: 95.4.h),
          InkWell(
            onTap: () {},
            child: Text(
              'Recent Scans Preview',
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
          SizedBox(height: 19.4.h),

          /// Card List
          /// Recent Scans Preview
          history.isEmpty
              ? Center(child: Text('No data'))
              : Column(
                  children: List.generate(
                    (history.length < 5 ? history.length : 5),
                    (index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15.12.h),
                        child: InkWell(
                          onTap: () async {
                            await History.clear();
                          },
                          child: CustomCardWidget(
                            title: history[index]!.scanType.toString(),
                            subTitle: history[index]!.scanType.toString(),
                            trailingTitle: history[index]!.data.toString(),
                            trailingSubTitle: history[index]!.dateTime
                                .toString(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  void getData() async {
    final data = await RecentHistoryStorage.getData();
    print(data.length);
    if (data.isNotEmpty) {
      history = data;
      setState(() {});
    }
  }
}
