import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scan_app/pres/app_color/app_colors.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nav_bar_event.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nave_bar_bloc.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nave_state.dart';
import 'package:scan_app/pres/pages/history_page/history_page.dart';
import 'package:scan_app/pres/pages/home_page/home_page.dart';
import 'package:scan_app/pres/pages/home_page/widgets/scan_circle_button.dart';
import 'package:scan_app/pres/pages/nave_bar_page/widgets/bottom_nave_bar.dart';
import 'package:scan_app/pres/pages/settings_page/settings_page.dart';

import '../live_scanner/live_scanner.dart';

class NaveBar extends StatelessWidget {
  const NaveBar({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screenList = [HistoryPage(), HomePage(), SettingsPage()];

    return BlocConsumer<NaveBarBloc, NaveBarState>(
      listener: (context, state) {
        if (state is OpenScannerState) {
          screenList.insert(1, QrCodeScanner());
        } else {
          screenList.insert(1, HomePage());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: screenList.elementAt(state.value),
          backgroundColor: AppColors.white,

          bottomNavigationBar: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              BottomNaveBar(),
              Positioned(
                bottom: 99.h / 2,
                child: ScanCircleButton(
                  onTap: () {
                    context.read<NaveBarBloc>().add(OpenScannerEvent());
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
