import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart' hide BarcodeFormat, Barcode;

import 'package:scan_app/pres/bloc/scanner_bloc/scanner_states.dart';

class ScannerHandler {
  ScannerHandler._();

  static pickImage({required Emitter<ScannerStates> emit}) async {
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
  }) {
    final code = barcode.barcodes.first.rawValue;
    final formate = barcode.barcodes.first;
    if (code != null) {
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
}
