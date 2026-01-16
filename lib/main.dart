import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_app/paractice/paractice.dart';
import 'package:scan_app/pres/bloc/export_excel_bloc/excel_bloc.dart';
import 'package:scan_app/pres/bloc/export_excel_bloc/excel_event.dart';
import 'package:scan_app/pres/bloc/history_bloc/history_bloc.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nave_bar_bloc.dart';
import 'package:scan_app/pres/bloc/scan_save_bloc/category_bloc.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_bloc.dart';
import 'package:scan_app/pres/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: Size(390, 844),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => NaveBarBloc()),
          BlocProvider(create: (context) => ScannerBloc()),
          BlocProvider(create: (context) => HistoryBloc()),
          BlocProvider(create: (context) => CategoryBloc()),
          BlocProvider(create: (context) => ExportExcelBloc()),
          //  BlocProvider(create: (context) => PracticeBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
