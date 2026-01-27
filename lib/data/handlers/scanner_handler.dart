import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart' hide BarcodeFormat, Barcode;
import 'package:scan_app/data/models/history_model.dart';
import 'package:scan_app/data/storage/recent_history.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_bloc.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_events.dart';
import 'package:scan_app/pres/bloc/scanner_bloc/scanner_states.dart';
import 'package:scan_app/pres/widgets/save_dilog.dart';
import 'package:share_plus/share_plus.dart';
import '../../pres/widgets/dialog.dart';

class ScannerHandler {
  ScannerHandler._();

  static pickImage({
    required Emitter<ScannerStates> emit,
    required BuildContext context,
  }) async {
    final picker = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (picker != null) {
      final pickImage = File(picker.path);

      final inputImage = InputImage.fromFilePath(pickImage.path);

      final barcodeScanner = BarcodeScanner(
        formats: [BarcodeFormat.values.first],
      );

      final barcode = await barcodeScanner.processImage(inputImage);

      final formate = barcode.first;
      List<String?> barcodes = [];
      if (barcode.isNotEmpty) {
        if (!context.mounted) return;
        context.read<ScannerBloc>().add(
          ScanVibrationSoundEvent(context: context),
        );
        for (var b in barcode) {
          barcodes.add(b.rawValue);
        }
        if (emit.isDone) return;
        emit(
          ImageState(
            barcodeList: barcodes,
            formate: formate.format == BarcodeFormat.qrCode
                ? 'Qr Code'
                : 'Barcode',
          ),
        );

        await barcodeScanner.close();
      } else {
        if (emit.isDone) return;
        emit(ErrorState(error: 'Scan failed'));
      }
    } else {
      print('Image is Empty');
    }
  }

  static liveScan({
    required Emitter<ScannerStates> emit,
    required BarcodeCapture barcode,
    required BuildContext context,
  }) async {
    final code = barcode.barcodes.first.rawValue;
    final formate = barcode.barcodes.first;
    if (code != null) {
      if (!context.mounted) return;

      context.read<ScannerBloc>().add(
        ScanVibrationSoundEvent(context: context),
      );

      if (emit.isDone) return;
      emit(
        ScanQrCodeState(
          data: code.toString(),
          formate: formate.format == BarcodeFormat.qrCode
              ? 'Qr Code'
              : 'Barcode',
        ),
      );
    } else {
      if (emit.isDone) return;
      emit(ErrorState(error: 'Scan failed'));
    }
  }

  static stateHandler({
    required BuildContext context,
    required ScannerStates state,
    required MobileScannerController liveScannerController,
    required bool torch,
  }) async {
    DateTime now = DateTime.now();

    if (state is ErrorState) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.error.toString())));
    }

    if (state is ScanQrCodeState) {
      if (state.data != null) {
        await liveScannerController.stop();
        if (!context.mounted) return;
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => InvoiceQrDialog(
            controller: liveScannerController,
            backAction: () {
              Navigator.of(context).pop();
              liveScannerController.start();
            },
            copyAction: () {
              Clipboard.setData(ClipboardData(text: state.data.toString()));
            },
            shareAction: () {
              Share.share(state.data.toString());
            },
            saveAction: () async {
              Navigator.pop(context);

              await showDialog(
                context: context,
                builder: (context) => ScanSaveDialog(
                  scanedData: state.data,
                  scanName: state.formate,
                ),
              );

              print('My data //////////////// ${state.data}');
              liveScannerController.start();
            },
            headerTitle: state.formate.toString(),
            scanType: state.formate.toString(),
            typeTitle: 'Result',
            data: state.data,
            date: DateFormat('EEEE, dd MMM yyyy').format(now).toString(),
          ),
        );

        /// Save data for recent prview
        HistoryModel model = HistoryModel(
          productName: state.formate,
          data: state.data,
          scanType: state.formate,
          category: '',
          dateTime: DateFormat('EEEE, dd MMM yyyy').format(now).toString(),
        );
        await RecentHistoryStorage.setRecentHistory(model);
      }
    }

    if (state is ImageState) {
      if (state.barcodeList.isNotEmpty) {
        liveScannerController.stop();
        if (!context.mounted) return;
        await showDialog(
          context: context,
          barrierDismissible: false,

          builder: (_) => InvoiceQrDialog(
            controller: liveScannerController,
            backAction: () {
              Navigator.of(context).pop();
            },
            copyAction: () {
              Clipboard.setData(
                ClipboardData(text: state.barcodeList.toString()),
              );
            },
            shareAction: () {
              Share.share(state.barcodeList.toString());
            },
            saveAction: () async {
              Navigator.pop(context);

              showDialog(
                context: context,
                builder: (context) => ScanSaveDialog(
                  scanedData: state.barcodeList.first,
                  scanName: state.formate,
                ),
              );
            },
            headerTitle: state.formate.toString(),
            scanType: state.formate.toString(),
            typeTitle: 'Result',
            data: state.barcodeList.first,
            date: DateFormat('EEEE, dd MMM yyyy').format(now).toString(),
          ),
        );

        /// Save data for recent preview
        HistoryModel model = HistoryModel(
          productName: state.formate,
          data: state.barcodeList.toString(),
          scanType: state.formate,
          category: '',
          dateTime: DateFormat('EEEE, dd MMM yyyy').format(now).toString(),
        );
        await RecentHistoryStorage.setRecentHistory(model);
        liveScannerController.start();
      }
    }
    if (state is ScannerTorchState) {
      torch = state.torch;
    }
  }
}
