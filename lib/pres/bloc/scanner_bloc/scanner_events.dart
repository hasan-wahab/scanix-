import 'package:flutter/cupertino.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

abstract class ScannerEvent {}

class OpenGalleryEvent extends ScannerEvent {
  BuildContext context;
  OpenGalleryEvent({required this.context});
}

class ScanQrCodeEvent extends ScannerEvent {
  BarcodeCapture barcode;

  ScanQrCodeEvent({required this.barcode});
}

class TorchEvent extends ScannerEvent {
  bool torch;
  TorchEvent({required this.torch});
}
