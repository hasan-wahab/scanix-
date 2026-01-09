import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scan_app/data/handlers/scanner_handler.dart';
import 'package:scan_app/pres/app_color/app_colors.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nav_bar_event.dart';
import 'package:scan_app/pres/bloc/nave_bar_bloc/nave_bar_bloc.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_bloc.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_events.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_states.dart';
import 'package:scan_app/pres/widgets/loading.dart';

import '../../widgets/dialog.dart';

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

  onLiveScan(BarcodeCapture barcode) async {
    final String? code = barcode.barcodes.first.rawValue;
    if (code != null && !isScanned) {
      setState(() {
        isScanned = true;
        result = code;
      });

      if (isScanned == true) {
        await liveScannerController.stop();

        if (kDebugMode) {
          print("Scanned QR: $code");
        }

        final url = Uri.parse(code);
        try {
          if (code.isNotEmpty) {
            http.Response response = await http.get(url);

            if (response.statusCode == 200) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: InkWell(onTap: () {}, child: Text(response.body)),
                ),
              );
            }
          }
        } on Exception catch (e) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: InkWell(onTap: () {}, child: Text(e.toString())),
            ),
          );
        }
        // setState(() {
        //   isScanned = false;
        // });
        // await liveScannerController.start();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<NaveBarBloc>().add(NaveBarIndexEvent(value: 1));
        return false;
      },
      child: BlocConsumer<ScannerBloc, ScannerStates>(
        listener: (context, state) async {
          if (state is ErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error.toString())));
          }

          // if (state is LoadingState) {
          //   if (state.isLoading == true) {
          //     AppLoading.showLoadingDialog(context);
          //   }
          //}
          if (state is ScanQrCodeState) {
            if (state.data != null) {
              liveScannerController.stop();
              await showDialog(
                context: context,
                barrierDismissible: false,

                builder: (_) => InvoiceQrDialog(
                  backAction: () {
                    Navigator.of(context).pop();
                    liveScannerController.start();
                  },
                  headerTitle: state.formate.toString(),
                  scanType: state.formate.toString(),
                  typeTitle: state.formate.toString(),
                  data: state.data,
                  date: DateTime.now().toString(),
                ),
              );
              liveScannerController.start();
            }
          }

          if (state is ImageState) {
            if (state.barcodeList.isNotEmpty) {
              await showDialog(
                context: context,
                barrierDismissible: false,

                builder: (_) => InvoiceQrDialog(
                  backAction: () {
                    Navigator.of(context).pop();
                  },
                  headerTitle: state.formate.toString(),
                  scanType: state.formate.toString(),
                  typeTitle: state.formate.toString(),
                  data: state.barcodeList.first,
                  date: DateTime.now().toString(),
                ),
              );
              liveScannerController.start();
            }
          }
          if (state is ScannerTorchState) {
            torch = state.torch;
          }
        },
        builder: (context, state) {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                MobileScanner(
                  //   errorBuilder: (context,err){
                  // =    print(err.errorCode);
                  //   },
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
}
