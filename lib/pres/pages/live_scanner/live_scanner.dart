import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan_app/data/handlers/scanner_handler.dart';
import 'package:scan_app/pres/app_color/app_colors.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nav_bar_event.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nave_bar_bloc.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_bloc.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_events.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_states.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key});

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  MobileScannerController liveScannerController = MobileScannerController(
    formats: [BarcodeFormat.values.first, BarcodeFormat.values.last],
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );
  bool isScanned = false;
  bool torch = false;

  String result = 'No Qr Code Scanned';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<NaveBarBloc>().add(NaveBarIndexEvent(value: 1));
        return false;
      },
      child: BlocConsumer<ScannerBloc, ScannerStates>(
        listener: (context, state) async {
          ScannerHandler.stateHandler(
            context: context,
            state: state,
            liveScannerController: liveScannerController,
            torch: torch,
          );
        },
        builder: (context, state) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                MobileScanner(
                  tapToFocus: true,
                  controller: liveScannerController,
                  onDetect: (BarcodeCapture barcode) {
                    context.read<ScannerBloc>().add(
                      ScanQrCodeEvent(barcode: barcode),
                    );
                  },
                ),
                Positioned(
                  top: 82.32.h,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      width: MediaQuery.sizeOf(context).width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<ScannerBloc>().add(
                                OpenGalleryEvent(context: context),
                              );
                            },
                            child: Card(
                              color: AppColors.text,
                              child: SizedBox(
                                height: 41.h,
                                width: 41.w,
                                child: Icon(
                                  Icons.image,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              liveScannerController.toggleTorch();
                              context.read<ScannerBloc>().add(
                                TorchEvent(torch: torch = !torch),
                              );
                            },
                            child: Card(
                              color: AppColors.text,
                              child: SizedBox(
                                height: 41.h,
                                width: 41.w,
                                child: Icon(
                                  torch
                                      ? Icons.flash_on_rounded
                                      : Icons.flash_off_outlined,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 250.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(width: 5, color: AppColors.primary),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    liveScannerController.dispose();
    super.dispose();
  }
}
