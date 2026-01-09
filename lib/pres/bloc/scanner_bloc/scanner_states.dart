import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

abstract class ScannerStates {}

class InitState extends ScannerStates {}

class OpenGalleryState extends ScannerStates {}

class ImageState extends ScannerStates {
  final List<String?> barcodeList;
  final String? formate;

  ImageState({required this.barcodeList, this.formate});
}

class ErrorState extends ScannerStates {
  String? error;
  ErrorState({this.error = ''});
}

class LoadingState extends ScannerStates {
  bool isLoading;
  LoadingState({this.isLoading = false});
}

class ScanQrCodeState extends ScannerStates {
  final String? data;
  final String? formate;
  ScanQrCodeState({this.data, this.formate});
}

class ScannerTorchState extends ScannerStates {
  bool torch;
  ScannerTorchState({this.torch = false});
}
