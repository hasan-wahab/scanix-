import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:scan_app/data/models/history_model.dart';
import 'package:scan_app/data/storage/histrory.dart';
import 'package:scan_app/pres/app_color/app_colors.dart';
import 'package:scan_app/pres/bloc/history_bloc/history_bloc.dart';
import 'package:scan_app/pres/bloc/history_bloc/history_event.dart';
import 'package:scan_app/pres/bloc/history_bloc/history_state.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nav_bar_event.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nave_bar_bloc.dart';
import 'package:scan_app/pres/pages/detail_page/detail_page.dart';
import 'package:scan_app/pres/widgets/app_btn.dart';
import 'package:scan_app/pres/widgets/custom_cord_widget.dart';
import 'package:scan_app/pres/widgets/loading.dart';
import 'package:scan_app/pres/widgets/save_dilog.dart';

import '../../bloc/export_excel_bloc/excel_bloc.dart';
import '../../bloc/export_excel_bloc/excel_event.dart';
import '../../bloc/export_excel_bloc/excel_state.dart';
import '../../widgets/app_t_field.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HistoryBloc>().add(GetDataEvent(key: 'data'));
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state is GetHistoryState) {
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
                      onTap: () async {
                        context.read<NaveBarBloc>().add(
                          NaveBarIndexEvent(value: 1),
                        );
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
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CircularProgressIndicator()],
                      );
                    }

                    return AppBtn(
                      onTap: () {
                        context.read<ExportExcelBloc>().add(
                          ExportUsersToExcel(),
                        );
                        print('Export to excel');
                      },

                      title: 'Export to Excel',
                      icon: CupertinoIcons.doc,
                    );
                  },
                ),
                SizedBox(height: 13.96.h),

                state.model!.isNotEmpty
                    ? SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.60,
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              (state.model!.length),
                              (index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => DetailPage(
                                        data: state.model![index]!,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: index + 1 == state.model!.length
                                        ? 100.3.h
                                        : 16.4.h,
                                  ),
                                  child: CustomCardWidget(
                                    title: state.model![index]!.productName
                                        .toString(),
                                    subTitle: DateFormat('EEEE, dd MMM yyyy')
                                        .format(
                                          DateTime.parse(
                                            state.model![index]!.dateTime
                                                .toString(),
                                          ),
                                        ),
                                    trailingIcon:
                                        Icons.arrow_forward_ios_outlined,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 400,

                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              await History.clear();
                            },
                            child: Text('No data'),
                          ),
                        ),
                      ),
              ],
            ),
          );
        } else if (state is HistoryLoadingState) {
          AppLoading.showLoadingDialog(context);

          return Container();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
