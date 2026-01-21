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

import '../../bloc/export_excel_bloc/excel_bloc.dart';
import '../../bloc/export_excel_bloc/excel_event.dart';
import '../../bloc/export_excel_bloc/excel_state.dart';
import '../../widgets/app_t_field.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    context.read<HistoryBloc>().add(GetDataEvent(key: 'data'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryBloc, HistoryState>(
      listener: (context, state) async {
        if (state is HistoryLoadingState) {
          AppLoading.showLoadingDialog(context);
        }
        if (state is GetHistoryState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        print(state);
        if (state is GetHistoryState) {
          return _buildHistoryUI(context, state.model ?? []);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildHistoryUI(
    BuildContext context,
    List<HistoryModel?> historyList,
  ) {
    return Container(
      color: AppColors.bgColor,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        children: [
          SizedBox(height: 54.26.h),

          /// HEADER
          Row(
            children: [
              InkWell(
                onTap: () {
                  context.read<NaveBarBloc>().add(NaveBarIndexEvent(value: 1));
                },
                child: const Icon(Icons.arrow_back_ios_new),
              ),
              SizedBox(width: 10.w),
              Text('History', style: TextStyle(fontSize: 20.sp)),
            ],
          ),

          SizedBox(height: 22.81.h),

          /// SEARCH
          AppTField(hintText: 'Search here'),
          SizedBox(height: 13.33.h),

          Row(
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

          /// EXPORT EXCEL
          BlocConsumer<ExportExcelBloc, ExportExcelState>(
            listener: (context, state) {
              if (state is ExportExcelSuccess) {
                OpenFile.open(state.filePath);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Excel saved successfully')),
                );
              }

              if (state is ExportExcelError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is ExportExcelLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return AppBtn(
                title: 'Export to Excel',
                icon: CupertinoIcons.doc,
                onTap: () {
                  context.read<ExportExcelBloc>().add(
                    ExportUsersToExcel(key: 'data'),
                  );
                },
              );
            },
          ),

          SizedBox(height: 14.h),

          historyList.isNotEmpty
              ? SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.60,
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(historyList.length, (index) {
                        final item = historyList[index]!;
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => DetailPage(data: item),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: index + 1 == historyList.length
                                  ? 100.h
                                  : 16.h,
                            ),
                            child: CustomCardWidget(
                              title: item.productName ?? '',
                              subTitle: DateFormat(
                                'EEEE, dd MMM yyyy',
                              ).format(DateTime.parse(item.dateTime!)),
                              trailingIcon: Icons.arrow_forward_ios_outlined,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
